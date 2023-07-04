Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D02EB64D9
	for <linux-hardening@archiver.kernel.org>; Tue,  4 Jul 2023 16:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGDQsg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjGDQsf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 Jul 2023 12:48:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1021AC
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 09:48:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76EDE61313
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 16:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B95C433C7;
        Tue,  4 Jul 2023 16:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688489313;
        bh=YPfkrGYUwU/9AzXd3YqeMzeS+35IL3VcXuZdYfaT0gk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=SWvyh1gyZo1+8NXvrmMjJ7CSCdaQ/hpUSU/IUTn8oRAQTyEx5fAMte1MPgAU1WjKQ
         LOtf2KeatghYGBO0yfvGNxbGAQoHgXOgmuYkEEBd1uPdDvU0NUDvM7IUT3zb6eTHV/
         OXnBaRARH+7XTEX0qO6dVpaod4XRAJpnMNA/6P2YiH/flfjG77GtQP310rpLMzpEOf
         XrrCQ2oqYS568swDFg609VUKRhEWT2xJyT3o37IBGd5MHrYDoMq1G/v8dZqiEsfRfH
         pX5twAAvRyK0la6cx+QzIAhNQ7ttyGww6wYH0/Bj0NvpHwYjIM7WKLIfDTK6YMHq7R
         CYMAK7feLMjQA==
Date:   Tue, 04 Jul 2023 09:48:30 -0700
From:   Kees Cook <kees@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-hardening@vger.kernel.org
CC:     Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_pstore=3A_Replace_crypto_API_?= =?US-ASCII?Q?compression_with_zlib=5Fdeflate_library_calls?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230704135211.2471371-3-ardb@kernel.org>
References: <20230704135211.2471371-1-ardb@kernel.org> <20230704135211.2471371-3-ardb@kernel.org>
Message-ID: <D690FB7B-BE46-4A56-9BDE-AB84652997D3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On July 4, 2023 6:52:11 AM PDT, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>@@ -217,10 +220,6 @@ static void allocate_buf_for_compression(void)
>=20
> static void free_buf_for_compression(void)
> {
>-	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm) {
>-		crypto_free_comp(tfm);
>-		tfm =3D NULL;
>-	}
> 	kfree(big_oops_buf);
> 	big_oops_buf =3D NULL;
> 	big_oops_buf_sz =3D 0;

I think this is missing a free of compress_workspace? Everything else look=
s great! What kind of testing did you do for this series?


--=20
Kees Cook
