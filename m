Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1AFC433ED
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Apr 2021 12:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE9761164
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Apr 2021 12:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhDBMkP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Apr 2021 08:40:15 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:56992 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBMkO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Apr 2021 08:40:14 -0400
Date:   Fri, 02 Apr 2021 12:40:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1617367211; bh=DnRWb/ENWowUkZ8iMTc38PO0CZerw5Mgien+btzdpIs=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=f2ok6exh3P/IMfzSxhSEdxRg0SrKbm4qlxRtZlo1amxNMOVigSbPpx89+eCpKjh/x
         CPLUsT38kheCkovQjvGAknk5XXH6ckD6gXapDIIr8hCZAvyxGDrK0MuU1GVZjb/28C
         wqMP8JPWVmJEcZkyQROhUobTS9yv5fQbx1YAyR9gb4f/ZlcDnJbKYGZMXPb6RrX547
         zpImCnpHuypY375B/xgiTkFfvDakg5+M6qw8M1aDHhlcD33cXrHdb1alXAxRtNOZaD
         a1NRg9xO0qo2V25OwSRkKY77Rm9J5Dk8FibIOdu933XH1s/nSaPjDcLeLqRBc+YxaW
         S+5MH+n1mpv0A==
To:     Kees Cook <keescook@chromium.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Jessica Yu <jeyu@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH] kbuild: merge module sections under CONFIG_LD_DEAD_CODE_DATA_ELIMINATION too
Message-ID: <20210402123959.5143-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When building with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
-fdata-sections and -ffunction-sections are being enabled by the
top-level Makefile, and module section merging is also needed.
Expand the ifdef (and the comment block) to cover that case too.

Fixes: 6a3193cdd5e5 ("kbuild: lto: Merge module sections if and only if CON=
FIG_LTO_CLANG is enabled")
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 scripts/module.lds.S | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 2c52535f9b56..d6bbdfc55e08 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -20,11 +20,14 @@ SECTIONS {

 =09__patchable_function_entries : { *(__patchable_function_entries) }

-#ifdef CONFIG_LTO_CLANG
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CL=
ANG)
 =09/*
 =09 * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
-=09 * -ffunction-sections, which increases the size of the final module.
-=09 * Merge the split sections in the final binary.
+=09 * -ffunction-sections. With CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
+=09 * -fdata-sections and -ffunction-sections are being enabled by
+=09 * the top-level Makefile.
+=09 * This increases the size of the final module. Merge the split
+=09 * sections in the final binary.
 =09 */
 =09.bss : {
 =09=09*(.bss .bss.[0-9a-zA-Z_]*)
--
2.31.1


