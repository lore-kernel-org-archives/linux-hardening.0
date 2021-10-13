Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AD7C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140B260FDA
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhJMPZD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhJMPZD (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 11:25:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6FDE610E6;
        Wed, 13 Oct 2021 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634138580;
        bh=5k0BYZS5Q/5ehvuCNbkjkrQtkcOaZ95KgwqdtymNMw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rSRQFnixLFq34y1EmGz+pYyqzxOdxSI4yOx9AbRTj4cI4zLBmJ8TxtRaPcb7bOmGb
         Y5O1OgCZjvs9jIARptaA3X3uo6yVxOfFdu2qvgJNF0VvgVH3EcwKBO0GozomRepUjv
         r+DgAG6o/ZPLRKSNqm9yGQTNyknbNu4cEwZrID6hdpJUtp6CDsfjQn/PzZYFcdy5/9
         nAonJzEJ86RxbsnR92LuO2YLPJHLtJeBfoWi4/cOU8A8bkXI0dG82V8KgBkwzOtGtJ
         l/H53p9iFLKb9YU+TqGuVCH9w2YHLXceaTnmxUJbCUeA1oqkPWBn+8bn9A1IIx4jfz
         blR5RPYRMZFGA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH 3/9] arm64: crypto: avoid overlapping linkage definitions for AES-CBC
Date:   Wed, 13 Oct 2021 17:22:37 +0200
Message-Id: <20211013152243.2216899-4-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013152243.2216899-1-ardb@kernel.org>
References: <20211013152243.2216899-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; h=from:subject; bh=5k0BYZS5Q/5ehvuCNbkjkrQtkcOaZ95KgwqdtymNMw8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhZvm2ZdTKQVU79efbhhoiav8D8jmUODgZpp6seolz 7krY+66JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYWb5tgAKCRDDTyI5ktmPJPCzC/ 9TsCXIseJHAZqVmbMAnkuIb2BaOu1gpH+jsUsy0F/6R4DS9LOLaM3mxG3DdO5C/FSkAqKWoNNIBeM7 ZnDp01QfO4/qYC4fwqjHTqGQDWyDvJzsdTcWfTpDSRhtY9JLoMsUdsLvT30YITusiEbF5XFbTitXI0 92baTTP8u1kLey0vAQeKf6BII9scGDQouFc417QAo9J7V5G+JOPlm4K9My6wU/y4/uzSIiOo9UPxIh w7OYHP47Lgte9pdS+OpXPQ6PzMUOzO2r39gliZbQZ6CdFzLq5ZuOq49YA99t7I+QFu4SO3EH5SmdUc ATAbhDNNhdiZM6XZJvlZoPM0uT7iupzy6koBXLoK9vJaP3ncdZ1k4mE0NDojqIhVGbiu3Cso+tR/9z FuKzsIvXIxQVet2++w0P18BCxL5oDLfz/1gAvrJg2jySIEfK/pO0qugsBQTU03QM6kcV5OyE4DfKza cPRzKRIOjZ6V6ZFRekTkKs0i54bRYl5uWjA9dYP4dQ6n8=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The aes_essiv_cbc_[en|de]crypt routines perform a single AES block
encryption of the IV before tail calling into the ordinary AES-CBC
routines to perform the actual data en/decryption. In the asm code, the
symbol definitions currently overlap, which is unnecessary, and becomes
problematic once we enable generation of CFI unwind metadata. So
instead, move the end marker of the ESSIV versions right after the
respective tail calls.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/aes-modes.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
index b495de22bb38..50427301b4d8 100644
--- a/arch/arm64/crypto/aes-modes.S
+++ b/arch/arm64/crypto/aes-modes.S
@@ -134,6 +134,7 @@ AES_FUNC_START(aes_essiv_cbc_encrypt)
 	encrypt_block	v4, w8, x6, x7, w9
 	enc_switch_key	w3, x2, x6
 	b		.Lcbcencloop4x
+AES_FUNC_END(aes_essiv_cbc_encrypt)
 
 AES_FUNC_START(aes_cbc_encrypt)
 	ld1		{v4.16b}, [x5]			/* get iv */
@@ -168,7 +169,6 @@ AES_FUNC_START(aes_cbc_encrypt)
 	st1		{v4.16b}, [x5]			/* return iv */
 	ret
 AES_FUNC_END(aes_cbc_encrypt)
-AES_FUNC_END(aes_essiv_cbc_encrypt)
 
 AES_FUNC_START(aes_essiv_cbc_decrypt)
 	stp		x29, x30, [sp, #-16]!
@@ -180,6 +180,7 @@ AES_FUNC_START(aes_essiv_cbc_decrypt)
 	enc_prepare	w8, x6, x7
 	encrypt_block	cbciv, w8, x6, x7, w9
 	b		.Lessivcbcdecstart
+AES_FUNC_END(aes_essiv_cbc_decrypt)
 
 AES_FUNC_START(aes_cbc_decrypt)
 	stp		x29, x30, [sp, #-16]!
@@ -239,7 +240,6 @@ ST5(	st1		{v4.16b}, [x0], #16		)
 	ldp		x29, x30, [sp], #16
 	ret
 AES_FUNC_END(aes_cbc_decrypt)
-AES_FUNC_END(aes_essiv_cbc_decrypt)
 
 
 	/*
-- 
2.30.2

