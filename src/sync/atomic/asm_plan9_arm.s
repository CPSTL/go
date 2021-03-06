// Copyright 2012 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

#include "textflag.h"

#define DMB_ISH_7 \
	MOVB	runtime·goarm(SB), R11; \
	CMP	$7, R11; \
	BLT	2(PC); \
	DMB	MB_ISH

// Plan9/ARM atomic operations.
// TODO(minux): this only supports ARMv6K or higher.

TEXT ·CompareAndSwapInt32(SB),NOSPLIT,$0
	B ·CompareAndSwapUint32(SB)

TEXT ·CompareAndSwapUint32(SB),NOSPLIT,$0
	B ·armCompareAndSwapUint32(SB)

TEXT ·CompareAndSwapUintptr(SB),NOSPLIT,$0
	B ·CompareAndSwapUint32(SB)

TEXT ·AddInt32(SB),NOSPLIT,$0
	B ·AddUint32(SB)

TEXT ·AddUint32(SB),NOSPLIT,$0
	B ·armAddUint32(SB)

TEXT ·AddUintptr(SB),NOSPLIT,$0
	B ·AddUint32(SB)

TEXT ·SwapInt32(SB),NOSPLIT,$0
	B ·SwapUint32(SB)

TEXT ·SwapUint32(SB),NOSPLIT,$0
	B ·armSwapUint32(SB)

TEXT ·SwapUintptr(SB),NOSPLIT,$0
	B ·SwapUint32(SB)

TEXT ·CompareAndSwapInt64(SB),NOSPLIT,$0
	B ·CompareAndSwapUint64(SB)

TEXT ·CompareAndSwapUint64(SB),NOSPLIT|NOFRAME,$0
	B ·armCompareAndSwapUint64(SB)

TEXT ·AddInt64(SB),NOSPLIT,$0
	B ·addUint64(SB)

TEXT ·AddUint64(SB),NOSPLIT,$0
	B ·addUint64(SB)

TEXT ·SwapInt64(SB),NOSPLIT,$0
	B ·swapUint64(SB)

TEXT ·SwapUint64(SB),NOSPLIT,$0
	B ·swapUint64(SB)

TEXT ·LoadInt32(SB),NOSPLIT,$0
	B ·LoadUint32(SB)

TEXT ·LoadInt64(SB),NOSPLIT,$0
	B ·loadUint64(SB)

TEXT ·LoadUint64(SB),NOSPLIT,$0
	B ·loadUint64(SB)

TEXT ·LoadUintptr(SB),NOSPLIT,$0
	B ·LoadUint32(SB)

TEXT ·LoadPointer(SB),NOSPLIT,$0
	B ·LoadUint32(SB)

TEXT ·StoreInt32(SB),NOSPLIT,$0
	B ·StoreUint32(SB)

TEXT ·StoreUint32(SB),NOSPLIT,$0-8
	MOVW addr+0(FP), R1
	MOVW val+4(FP), R2
	DMB_ISH_7
storeloop:
	LDREX (R1), R4		// loads R4
	STREX R2, (R1), R0	// stores R2
	CMP $0, R0
	BNE storeloop
	RET

TEXT ·StoreInt64(SB),NOSPLIT,$0
	B ·storeUint64(SB)

TEXT ·StoreUint64(SB),NOSPLIT,$0
	B ·storeUint64(SB)

TEXT ·StoreUintptr(SB),NOSPLIT,$0
	B ·StoreUint32(SB)
