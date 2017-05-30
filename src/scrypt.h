#ifndef SCRYPT_H
#define SCRYPT_H

#include <stdlib.h>
#include <stdint.h>
#include <stddef.h>
#include <inttypes.h>

static const int SCRYPT_SCRATCHPAD_SIZE = 134218239;
static const int N = 1048576;

void scryptSquaredHash(const void *input, char *output);
extern unsigned char *scrypt_buffer_alloc();
extern "C" void scrypt_core(uint32_t *X, uint32_t *V, int N);
int scrypt_best_throughput();
extern "C" void sha256_transform(uint32_t *state, const uint32_t *block, int swap);

/*#if defined(__x86_64__)
#define SCRYPT_MAX_WAYS 12
#define HAVE_SCRYPT_3WAY 1
#define scrypt_best_throughput() 3;
extern "C" void scrypt_core_3way(uint32_t *X, uint32_t *V, int N);

#if defined(USE_AVX2)
#undef SCRYPT_MAX_WAYS
#define SCRYPT_MAX_WAYS 24
#define HAVE_SCRYPT_6WAY 1
extern "C" void scrypt_core_6way(uint32_t *X, uint32_t *V, int N);
#endif

#elif defined(__i386__)
#define SCRYPT_MAX_WAYS 1
#define scrypt_best_throughput() 1
extern "C" void scrypt_core(uint32_t *X, uint32_t *V, int N);

#elif defined(__arm__) && defined(__APCS_32__)
extern "C" void scrypt_core(uint32_t *X, uint32_t *V, int N);

#if defined(__ARM_NEON__)
#undef HAVE_SHA256_4WAY
#define SCRYPT_MAX_WAYS 1
#define HAVE_SCRYPT_3WAY 0
#define scrypt_best_throughput() 1
#endif
#endif
/*#if defined(__ARM_NEON__) || defined(__ALTIVEC__) || defined(__i386__) || defined(__x86_64__)
#define HAVE_SHA256_4WAY 1
extern "C" int sha256_use_4way();
extern "C" void sha256_init_4way(uint32_t *state);
extern "C" void sha256_transform_4way(uint32_t *state, const uint32_t *block, int swap);
#endif

#if defined(__x86_64__) && defined(USE_AVX2)
#define HAVE_SHA256_8WAY 1
extern "C" int sha256_use_8way();
extern "C" void sha256_init_8way(uint32_t *state);
extern "C" void sha256_transform_8way(uint32_t *state, const uint32_t *block, int swap);
#endif*/


#define bswap_32(x) ((((x) << 24) & 0xff000000u) | (((x) << 8) & 0x00ff0000u) \
                   | (((x) >> 8) & 0x0000ff00u) | (((x) >> 24) & 0x000000ffu))

static inline uint32_t swab32(uint32_t v)
{
    return bswap_32(v);
}
#endif
