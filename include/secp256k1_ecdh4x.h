#ifndef SECP256K1_ECDH4X_H
#define SECP256K1_ECDH4X_H

#include "secp256k1.h"

typedef struct {
    unsigned char data[32];
} secp256k1_scalar_bytes;

typedef struct {
    unsigned char data[32];
} secp256k1_ecdh_output;

#ifdef __cplusplus
extern "C" {
#endif

/** A pointer to a function that hashes an EC point to obtain an ECDH secret
 *
 *  Returns: 1 if the point was successfully hashed.
 *           0 will cause secp256k1_ecdh to fail and return 0.
 *           Other return values are not allowed, and the behaviour of
 *           secp256k1_ecdh is undefined for other return values.
 *  Out:     output:     pointer to an array to be filled by the function
 *  In:      x32:        pointer to a 32-byte x coordinate
 *           y32:        pointer to a 32-byte y coordinate
 *           data:       arbitrary data pointer that is passed through
 */
typedef int (*secp256k1_ecdh_hash_function)(
  unsigned char *output,
  const unsigned char *x32,
  const unsigned char *y32,
  void *data
);

/** An implementation of SHA256 hash function that applies to compressed public key.
 * Populates the output parameter with 32 bytes. */
SECP256K1_API extern const secp256k1_ecdh_hash_function secp256k1_ecdh_hash_function_sha256;

/** A default ECDH hash function (currently equal to secp256k1_ecdh_hash_function_sha256).
 * Populates the output parameter with 32 bytes. */
SECP256K1_API extern const secp256k1_ecdh_hash_function secp256k1_ecdh_hash_function_default;

/** Compute 4 EC Diffie-Hellman secrets in constant time
 *
 *  Returns: 1: exponentiation was successful
 *           0: scalar was invalid (zero or overflow) or hashfp returned 0
 *  Args:    ctx:        pointer to a context object (cannot be NULL)
 *  Out:     output:     pointer to a 4-element aray of secp256k1_ecdh_output which stores the outputs of 4 scalar multiplications
 *  In:      pubkey:     pointer to a 4-element array of secp256k1_pubkey which contain 4 initialized public keys
 *           seckey:     pointer to a 4-element array of secp256k1_scalar_bytes which contain 4 32-byte scalars with which to multiply the ec-points
 *           hashfp:     pointer to a hash function. If NULL, secp256k1_ecdh_hash_function_sha256 is used
 *                       (in which case, 32 bytes will be written to output)
 *           data:       arbitrary data pointer that is passed through to hashfp
 */
SECP256K1_API SECP256K1_WARN_UNUSED_RESULT int secp256k1_ecdh4x(
  const secp256k1_context* ctx,
  secp256k1_ecdh_output *output,
  const secp256k1_pubkey *pubkey,
  const secp256k1_scalar_bytes *seckey,
  secp256k1_ecdh_hash_function hashfp,
  void *data
) SECP256K1_ARG_NONNULL(1) SECP256K1_ARG_NONNULL(2) SECP256K1_ARG_NONNULL(3) SECP256K1_ARG_NONNULL(4);

#ifdef __cplusplus
}
#endif

#endif /* SECP256K1_ECDH4X_H */


