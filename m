Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4978BC74A44
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Mar 2023 20:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCNUeH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Mar 2023 16:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCNUeE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Mar 2023 16:34:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72EA521D7
        for <linux-hardening@vger.kernel.org>; Tue, 14 Mar 2023 13:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B61CB81A16
        for <linux-hardening@vger.kernel.org>; Tue, 14 Mar 2023 20:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55546C433D2;
        Tue, 14 Mar 2023 20:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678826026;
        bh=iN04j8aiExsMR4SAjvFhCPSopIclwuHB2+vsqetGB2o=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=iKm/U88dPLeNEO5oJDVmAvXuVb10Y71r0ZhCoxjziuSF2Dh4EJ+dqg3EAyIEuYbuJ
         SZSU0KVhG4z8D2a0JczkZhM+c5Eobe08htv7TkVkAd5zsxqq7r9pTa2gWvPF4uHYxJ
         gcyMlbZ9DKrphNvnqzSvFQVsYv1mBAhm+X0k7Gp8BSg1NZ0cojHsEcSs61o18CYtUe
         XFv5WOd3exdV3LCKOYa3PY17nqBxwSPtVLNzD5/TqZmAOI3GSvM+uKDKj/daxtQPgE
         jn/9WroyzM//V0Qv/h1cDJaYlISHwEbImp/83vK+PS5tAHMvDYNYlVNvc/edPIY1Ko
         tHrby3V5jCcYg==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 31C8927C005B;
        Tue, 14 Mar 2023 16:33:44 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 14 Mar 2023 16:33:44 -0400
X-ME-Sender: <xms:JtoQZG5uOVBLkLKF3AJD5CjbZcLpQr_Dz0_-Z5YALn8JhNSaRHahSA>
    <xme:JtoQZP70CDtvpMBcGxIVjvPK-73pk0c2Fw-b3bnZbfOVDgy6LmQAjXF3ErIxy7fww
    z_XBH3KrEQqNDsFhN4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddviedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:JtoQZFfcdERFCZZYFeF32HRrnG5L4vAKMRA5fPY4VIqGmajLXS5iig>
    <xmx:JtoQZDJnz_pPFc9ODWmrbyegUA5LHhdUf8_jG6uvVKPiRroBY0sO6g>
    <xmx:JtoQZKKgYduelpNdf-ukaN6WctAta7EXcZoVup0zx8joP4D2MisShw>
    <xmx:KNoQZMjJELIj5Z6R8tmgCmH5saqssxNtLVXlDwuDI1gg6Lxg5vhNng>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7CCAA31A0063; Tue, 14 Mar 2023 16:33:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <259a1148-faf0-4765-b777-6f36459c9307@app.fastmail.com>
In-Reply-To: <dab948690a74db1bb75d95aa7e0362deeca6dbf4.1678785672.git.baskov@ispras.ru>
References: <cover.1678785672.git.baskov@ispras.ru>
 <dab948690a74db1bb75d95aa7e0362deeca6dbf4.1678785672.git.baskov@ispras.ru>
Date:   Tue, 14 Mar 2023 13:33:21 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Evgeniy Baskov" <baskov@ispras.ru>,
        "Ard Biesheuvel" <ardb@kernel.org>
Cc:     "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Alexey Khoroshilov" <khoroshilov@ispras.ru>,
        "Peter Jones" <pjones@redhat.com>,
        "Gerd Hoffmann" <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 09/27] x86/boot: Remove mapping from page fault handler
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Mar 14, 2023, at 3:13 AM, Evgeniy Baskov wrote:
> After every implicit mapping is removed, this code is no longer needed.
>
> Remove memory mapping from page fault handler to ensure that there are
> no hidden invalid memory accesses.

This patch is *by far* the scariest of the bunch in my boot.  And it violates a basic principle of kernel development: it's better to run in degraded mode than to fail outright unless running in degraded mode is dangerous for some reason.

And this boot code is not actually meaningfully exposed to attack.  Anyone who can get the boot code to consume garbage likely *already* controls the system, including anything that we might write to TPM or any other verification mechanism.

So I think this should log an error, set a flag to make sure we print an even louder error after full boot, but still add the mapping and keep trying.

--Andy

>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/compressed/ident_map_64.c | 26 ++++++++++---------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/ident_map_64.c 
> b/arch/x86/boot/compressed/ident_map_64.c
> index eb28ce9812c5..378f99b1d7e8 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -393,27 +393,21 @@ void do_boot_page_fault(struct pt_regs *regs, 
> unsigned long error_code)
>  {
>  	unsigned long address = native_read_cr2();
>  	unsigned long end;
> -	bool ghcb_fault;
> +	char *msg;
> 
> -	ghcb_fault = sev_es_check_ghcb_fault(address);
> +	if (sev_es_check_ghcb_fault(address))
> +		msg = "Page-fault on GHCB page:";
> +	else
> +		msg = "Unexpected page-fault:";
> 
>  	address   &= PMD_MASK;
>  	end        = address + PMD_SIZE;
> 
>  	/*
> -	 * Check for unexpected error codes. Unexpected are:
> -	 *	- Faults on present pages
> -	 *	- User faults
> -	 *	- Reserved bits set
> -	 */
> -	if (error_code & (X86_PF_PROT | X86_PF_USER | X86_PF_RSVD))
> -		do_pf_error("Unexpected page-fault:", error_code, address, regs->ip);
> -	else if (ghcb_fault)
> -		do_pf_error("Page-fault on GHCB page:", error_code, address, regs->ip);
> -
> -	/*
> -	 * Error code is sane - now identity map the 2M region around
> -	 * the faulting address.
> +	 * Since all memory allocations are made explicit
> +	 * now, every page fault at this stage is an
> +	 * error and the error handler is there only
> +	 * for debug purposes.
>  	 */
> -	kernel_add_identity_map(address, end, MAP_WRITE);
> +	do_pf_error(msg, error_code, address, regs->ip);
>  }
> -- 
> 2.39.2
