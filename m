Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9679BC433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 13 Nov 2021 23:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C9F60FE7
	for <linux-hardening@archiver.kernel.org>; Sat, 13 Nov 2021 23:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhKMXXc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 13 Nov 2021 18:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhKMXXc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 13 Nov 2021 18:23:32 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E6DC061767
        for <linux-hardening@vger.kernel.org>; Sat, 13 Nov 2021 15:20:39 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v11so53693857edc.9
        for <linux-hardening@vger.kernel.org>; Sat, 13 Nov 2021 15:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYXYvX3lQN+4CmLJKYnO/NxLt8YDnJHWgNGhZhL3hQE=;
        b=Zd//V0Bv4dOljddH6L9rcdZv+LkO8DvZZqyrsUMwBh15miSAPf/U+kY5JgHayJcHFu
         3iT+cHl0rK34NLFWtRYTNfd9mjDdrPHjp7qVKglcDdlOBRpx94uBKMS/14ueXkhP8Yhi
         17zo3S6pQq81EBsJLf3YX9KI7CHWT9UeGYrFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYXYvX3lQN+4CmLJKYnO/NxLt8YDnJHWgNGhZhL3hQE=;
        b=HuVuCgHD0irBcfw3lFEFi8KsTnGCBzbwsSJY4ya6VlKjVgK0k2KIhzOxD1Kx9TqZNr
         zx2pkNB8yPJcBbi5yi3kEJ8eMd+lRB3lWx0n5xsi/EvBLHi8hosEwvNtCXBrQlOMSQtc
         B5CQsH4dFrqY7Hsy3iCkM94S2eXpCvrya5Jkc1vRPFLQTYGe50hLNTnaEyrZTv7990Qx
         qojXdBC6jqvPxwsioifkJ92TXJWGNLPARhhwJ1dY2a1TPwcyldgX1jBBX9gZxdUdHjov
         1JTY6L0Cnl296UcR0bbNrEWthenssdTC2PxIl84UFQEUGQ4jUGJ6MtOs8BPI2yZd/NiC
         Qx+w==
X-Gm-Message-State: AOAM533MHKO8oVdl/qHGTW8v9g2xjzdmQtTJnU7vnSNgwOFkjW0Pb3lM
        nia8lgEJlsUeKNLA03WBxNg1nv9noGTQHqrU6bA=
X-Google-Smtp-Source: ABdhPJzOF49ihbTrd4D0S5S2SEo8ufytI6OPgggSyPMgD0pCgch+Axx0PQF7EX42Q279gckAYywv7w==
X-Received: by 2002:a17:906:dc90:: with SMTP id cs16mr33631682ejc.432.1636845637240;
        Sat, 13 Nov 2021 15:20:37 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id sg17sm4230358ejc.72.2021.11.13.15.20.35
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 15:20:36 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id b12so22507614wrh.4
        for <linux-hardening@vger.kernel.org>; Sat, 13 Nov 2021 15:20:35 -0800 (PST)
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr32369933wrm.229.1636845635529;
 Sat, 13 Nov 2021 15:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20211113214125.GA23640@embeddedor>
In-Reply-To: <20211113214125.GA23640@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Nov 2021 15:20:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj-yyR1s1LcnTspgpcriyX-nDruzSmEneA2U=bOj9gCuQ@mail.gmail.com>
Message-ID: <CAHk-=wj-yyR1s1LcnTspgpcriyX-nDruzSmEneA2U=bOj9gCuQ@mail.gmail.com>
Subject: Re: [GIT PULL] Enable -Wimplicit-fallthrough for Clang for 5.16-rc1
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a8b11e05d0b3d28f"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

--000000000000a8b11e05d0b3d28f
Content-Type: text/plain; charset="UTF-8"

On Sat, Nov 13, 2021 at 1:36 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> This patch has been baking in linux-next for a couple of developement
> cycles, now. So, I think we are pretty much ready to merge it into
> mainline.

Ugh. It's also very ugly.

Wouldn't something like this (TOTALLY UNTESTED!) work and do the right thing?

This seems like a natural for a Kconfig decision.

Also, does -Wimplicit-fallthrough=5 work with clang too? That would
simplify things a bit, and then we could just use a regular boolean
and do

  KBUILD_CFLAGS-$(CC_IMPLICIT_FALLTHROUGH) += -Wimplicit-fallthrough=5

in the Makefile, which is more in like with what we do for other
config-time cflags..

           Linus

--000000000000a8b11e05d0b3d28f
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kvyfj3pd0>
X-Attachment-Id: f_kvyfj3pd0

IE1ha2VmaWxlICAgICB8IDYgKy0tLS0tCiBpbml0L0tjb25maWcgfCA1ICsrKysrCiAyIGZpbGVz
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9N
YWtlZmlsZSBiL01ha2VmaWxlCmluZGV4IGQ4M2Q3MmMyNmFhYS4uOWNmOWQ1YzFlZDhmIDEwMDY0
NAotLS0gYS9NYWtlZmlsZQorKysgYi9NYWtlZmlsZQpAQCAtNzg5LDcgKzc4OSw3IEBAIHN0YWNr
cC1mbGFncy0kKENPTkZJR19TVEFDS1BST1RFQ1RPUl9TVFJPTkcpICAgICAgOj0gLWZzdGFjay1w
cm90ZWN0b3Itc3Ryb25nCiBLQlVJTERfQ0ZMQUdTICs9ICQoc3RhY2twLWZsYWdzLXkpCiAKIEtC
VUlMRF9DRkxBR1MtJChDT05GSUdfV0VSUk9SKSArPSAtV2Vycm9yCi1LQlVJTERfQ0ZMQUdTICs9
ICQoS0JVSUxEX0NGTEFHUy15KQorS0JVSUxEX0NGTEFHUyArPSAkKEtCVUlMRF9DRkxBR1MteSkg
JChDT05GSUdfQ0NfSU1QTElDSVRfRkFMTFRIUk9VR0gpCiAKIGlmZGVmIENPTkZJR19DQ19JU19D
TEFORwogS0JVSUxEX0NQUEZMQUdTICs9IC1RdW51c2VkLWFyZ3VtZW50cwpAQCAtODAxLDEwICs4
MDEsNiBAQCBLQlVJTERfQ0ZMQUdTICs9IC1Xbm8tZ251CiBLQlVJTERfQ0ZMQUdTICs9IC1tbm8t
Z2xvYmFsLW1lcmdlCiBlbHNlCiAKLSMgV2FybiBhYm91dCB1bm1hcmtlZCBmYWxsLXRocm91Z2hz
IGluIHN3aXRjaCBzdGF0ZW1lbnQuCi0jIERpc2FibGVkIGZvciBjbGFuZyB3aGlsZSBjb21tZW50
IHRvIGF0dHJpYnV0ZSBjb252ZXJzaW9uIGhhcHBlbnMgYW5kCi0jIGh0dHBzOi8vZ2l0aHViLmNv
bS9DbGFuZ0J1aWx0TGludXgvbGludXgvaXNzdWVzLzYzNiBpcyBkaXNjdXNzZWQuCi1LQlVJTERf
Q0ZMQUdTICs9ICQoY2FsbCBjYy1vcHRpb24sLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD01LCkKICMg
Z2NjIGluYW5lbHkgd2FybnMgYWJvdXQgbG9jYWwgdmFyaWFibGVzIGNhbGxlZCAnbWFpbicKIEtC
VUlMRF9DRkxBR1MgKz0gLVduby1tYWluCiBlbmRpZgpkaWZmIC0tZ2l0IGEvaW5pdC9LY29uZmln
IGIvaW5pdC9LY29uZmlnCmluZGV4IDQ1YmNhYThlNzQ4MS4uMDM2Yjc1MGU4ZDhhIDEwMDY0NAot
LS0gYS9pbml0L0tjb25maWcKKysrIGIvaW5pdC9LY29uZmlnCkBAIC04ODUsNiArODg1LDExIEBA
IGNvbmZpZyBBUkNIX1dBTlRfQkFUQ0hFRF9VTk1BUF9UTEJfRkxVU0gKIGNvbmZpZyBDQ19IQVNf
SU5UMTI4CiAJZGVmX2Jvb2wgISQoY2Mtb3B0aW9uLCQobTY0LWZsYWcpIC1EX19TSVpFT0ZfSU5U
MTI4X189MCkgJiYgNjRCSVQKIAorY29uZmlnIENDX0lNUExJQ0lUX0ZBTExUSFJPVUdICisJc3Ry
aW5nCisJZGVmYXVsdCAiLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD01IiBpZiBDQ19JU19HQ0MKKwlk
ZWZhdWx0ICItV2ltcGxpY2l0LWZhbGx0aHJvdWdoIiBpZiBDQ19JU19DTEFORyAmJiAkKGNjLW9w
dGlvbiwtV3VucmVhY2hhYmxlLWNvZGUtZmFsbHRocm91Z2gpCisKICMKICMgRm9yIGFyY2hpdGVj
dHVyZXMgdGhhdCBrbm93IHRoZWlyIEdDQyBfX2ludDEyOCBzdXBwb3J0IGlzIHNvdW5kCiAjCg==
--000000000000a8b11e05d0b3d28f--
