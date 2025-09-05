Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D3B32F76C
	for <linux-hardening@vger.kernel.org>; Fri,  5 Sep 2025 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056023; cv=none; b=Crv3tIaUADqgKQ4GQCavWWu44erxKC7hZeVEPbTb0HHyqHV4HZNM0zal0DW+Zj32D3YCuYjZkFIp+W2p8Y/zWFb2bysvY5C81TORhySy3KKfiVfv9Thq5nT0ByGMXyfpHw3P4grp/YpqYT8CV1mGzYmAy+I8ezmRK95zK5fgGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056023; c=relaxed/simple;
	bh=tDHelf7WEMjV7EOGWj9jpwbEDjmFIvSfhs0WB1gOfx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PHNuGHWn2Tb0R34k0Bewm1/eNqWv54tkZ+NCwjodeWL7UfOWIRrkgmCbE0Xs3FTPAydUs3W6m+LvjQtgZOW4ACP5wCJlewp5SLenYqPDDohuGgJe63U4HsqPGgWAsdusPY9pgaISS0bgP9cgpST3sMFZPZYPoa0IVAYMn1IW0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gsaf8mCr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gsaf8mCr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757056021;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=Ux3XLPCsvR2RUG+YaKSZ/r+FzeMFLOV7iYFFVNh/jRo=;
	b=Gsaf8mCrkEjJX35maCkpP9j8oqaVtLvd2Cit6n8zIqlw7U3J3X6azssKgNxqdO1Pc76geS
	47Bm+rBa0dsXrVYf5Mw6kNyAF3lv62W13r2e2utf2o7uPonGGufz1ftVUZk7ESqWZAaXKu
	XTQAw6jxfGimeF3kd9QfgrKRB7qJRsg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653--7omiWA6MTqyRQeulSIA6Q-1; Fri,
 05 Sep 2025 03:06:55 -0400
X-MC-Unique: -7omiWA6MTqyRQeulSIA6Q-1
X-Mimecast-MFC-AGG-ID: -7omiWA6MTqyRQeulSIA6Q_1757056012
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3D5B19560A0;
	Fri,  5 Sep 2025 07:06:50 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.45.224.56])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C78341954126;
	Fri,  5 Sep 2025 07:06:48 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
	by tucnak.zalov.cz (8.17.1/8.17.1) with ESMTPS id 58576jDM1532872
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 5 Sep 2025 09:06:45 +0200
Received: (from jakub@localhost)
	by tucnak.zalov.cz (8.17.1/8.17.1/Submit) id 58576ff51532869;
	Fri, 5 Sep 2025 09:06:41 +0200
Date: Fri, 5 Sep 2025 09:06:41 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
        Richard Biener <rguenther@suse.de>, Joseph Myers <josmyers@redhat.com>,
        Jan Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Li <ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon de C Valle <rcvalle@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 7/7] kcfi: Add regression test suite
Message-ID: <aLqMAWTwDh5eXgUJ@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-7-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250905002418.464643-7-kees@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bkLoKm_lyTYACPvbVtHoqShK2Fd7lVn1gO6vpOnlLIU_1757056012
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 04, 2025 at 05:24:15PM -0700, Kees Cook wrote:
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
> @@ -0,0 +1,73 @@
> +/* Test KCFI check/transfer adjacency - regression test for instruction
> +   insertion.  */
> +/* { dg-do compile } */
> +/* { dg-options "-fsanitize=kcfi -O2" } */
> +/* { dg-options "-fsanitize=kcfi -O2 -march=armv7-a -mfloat-abi=soft" { target arm32 } } */

For stuff like this you should be using dg-additional-options.
/* { dg-options "-fsanitize=kcfi -O2" } */
/* { dg-additional-options "-march=armv7-a -mfloat-abi=soft" { target arm32 } } */
(in various other tests too).

> +/* Should have KCFI instrumentation for all indirect calls.  */
> +
> +/* x86_64: Complete KCFI check sequence should be present.  */
> +/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r1[01]d\n\taddl\t[^,]+, %r1[01]d\n\tje\t\.Lkcfi_call[0-9]+\n\.Lkcfi_trap[0-9]+:\n\tud2} { target x86_64-*-* } } } */

This at least needs
/* { dg-additional-options "-masm=att" { target x86_64-*-* } } */
because Intel syntax wouldn't match.  Does this match with all possible
-march/-mtune settings?
Peope very often do test
make check RUNTESTFLAGS='--target_board=unix/-march=skylake-avx512'
etc. so if the test depends on a particular ISA or tuning, better
add it explicitly to dg-options.
Also, we try not to use triplets like x86_64-*-* but instead
{ i?86-*-* x86_64-*-* } && lp64
or
{ i?86-*-* x86_64-*-* } && { ! ia32 }
depending on whether it is only for -m64, or for both -m64 and -mx32,
because on some targets the multilib compiler is i?86-*-* defaulting
to -m32, on most obviously x86_64-*-* defaulting to -m64.

> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-basics.c
> @@ -0,0 +1,101 @@
> +/* Test basic KCFI functionality - preamble generation.  */
> +/* { dg-do compile } */
> +/* { dg-options "-fsanitize=kcfi" } */
> +/* { dg-options "-fsanitize=kcfi -falign-functions=16" { target x86_64-*-* } } */
> +/* { dg-options "-fsanitize=kcfi -march=armv7-a -mfloat-abi=soft" { target arm32 } } */

Again (and in many others).

> +/* x86_64: Should have 0 entry NOPs - function starts immediately with
> +   pushq.  */
> +/* { dg-final { scan-assembler {test_function:\n\.LFB[0-9]+:\n\t*\.cfi_startproc\n\t*pushq\t*%rbp} { target x86_64-*-* } } } */
> +/* { dg-final { scan-assembler-not {\t*\.weak\t*__kcfi_typeid_test_function\n} { target x86_64-*-* } } } */

.weak is ELF specific, not all targets have it, are the tests restricted to
targets that do support it and in this syntax?  We have
/* { dg-require-weak "" } */
but that doesn't imply a particular function.

Also, not all configurations will support .cfi_* directives, that depends
both on command line parameters and on whether assembler supports those.
If you expect them in all tests, perhaps you should test for those in
kcfi.exp and not run the tests at all if the directives aren't supported
(or if weak isn't supported etc.).
Also, there are targets with different line endings, so usually one scans
for [\n\r]* instead of just \n.  No idea why you're using \t*, the compiler
emits just one tab.

	Jakub

