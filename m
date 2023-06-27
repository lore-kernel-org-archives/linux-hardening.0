Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B4EEB64D9
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Jun 2023 17:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjF0RFT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Jun 2023 13:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjF0RFS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Jun 2023 13:05:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDE310FB
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jun 2023 10:05:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f9b9863bfdso3555e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jun 2023 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687885516; x=1690477516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nLbnFlyoJNJDBBlkz8JKOe6T7uVTYiMufakhNHN8pc=;
        b=GM5kpRnwTIQXRm2JOFsrvCN7oqAEa3c/ALUuhS9d+HHl65PFpaQ+gSev7Sf1aUKtGk
         2goAuOBdfbvbXTBxzjb3eZh97Dq0kbEz2kC2Wu+c308/ZWfEEJxEaThWEYB3CE6DwARZ
         lDNJOkHRdSx090rySGfpW5YKmaj0mvldXltbb/yeYOATzbzq5tT7MMnBjrBbEpi00DMz
         vD+8Rg87MG94rC+Y4lRPtKaLRXsZNob38Hq1crQXSy5wBaDQnrvvTm0e+zMUOmsBgDjq
         Bz6wMypFgcjYaDr7MwPo6Rdegmi3jDt9EQ+yCrbB4wvbFcpk/LM2wgdBtJ82GOb9CHe6
         OeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687885516; x=1690477516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nLbnFlyoJNJDBBlkz8JKOe6T7uVTYiMufakhNHN8pc=;
        b=RBC57zfRNs9Vw02/SAcjbramFeYfgPATzfdAAJphd4TUGEA+pJ+8w9rbXwmAqyW+Vq
         rI82uUK88kGPGo5uJ/x0XqvQ2aTU4sy7JE8k486WOAs28V8Ml/lBZtAM6T21R54lrd2V
         +uqqEUXxXVxfwVaQlCK/vy9UdcPxwci8KD0afnvSfjuHzv4ACmSfeou5wgPWWhi4yQrF
         X9zESpZ0Jat5U3l6Xd12qBZlyN3GsuOClK1i/X3Gqw851oweSr5nNhss2RwvKJ2wOGF1
         iC9tnZbA6s4HQMyaRTmSltlOo9oRHz4hYmVtfR3rFVXMem5Xb4qAD+DBExpJQ/+SLKKm
         uhSA==
X-Gm-Message-State: AC+VfDy0kFXpEA2CTJChJFNoCnkNgifXynq14NoPcDIW+EYtAJPCq1L7
        EPTXRiPCPShKUXF3+k8y6DmJAS3ShOV7HtaYmre2Zg==
X-Google-Smtp-Source: ACHHUZ6DJr9MnYp31T22fQMiVeMG4NNo7rn60TL5Trzs3XCbDjIix9JG6YleFhqaAltHVrzbctU6wCFPWfAOB0Tx/Ag=
X-Received: by 2002:a05:600c:b99:b0:3f4:2736:b5eb with SMTP id
 fl25-20020a05600c0b9900b003f42736b5ebmr148150wmb.1.1687885515753; Tue, 27 Jun
 2023 10:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAOOoKeQ=b4u1C_FZ-OFHSfVt5Z9xw1KtpJ4316zubt46Tny41Q@mail.gmail.com>
 <2023062715-eldercare-washed-3c29@gregkh>
In-Reply-To: <2023062715-eldercare-washed-3c29@gregkh>
From:   Yuxiao Zhang <yuxiaozhang@google.com>
Date:   Tue, 27 Jun 2023 10:05:04 -0700
Message-ID: <CAOOoKeSxJzJEwX2aVsn_jcqK7gsgEVpB3VdhoKjJPCJgdNf9Mg@mail.gmail.com>
Subject: Re: support pmsg record size larger than kmalloc limitation
To:     Greg KH <gregkh@linuxfoundation.org>,
        "yuxiaozh.zhang@gmail.com" <yuxiaozh.zhang@gmail.com>
Cc:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org,
        William Kennington <wak@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

  kfree(record->priv);
  kfree(record);
  if (rc !=3D -EEXIST || !quiet)
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ade66dbe5f39..296465b14fa9 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -20,6 +20,7 @@
 #include <linux/compiler.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/mm.h>

 #include "internal.h"
 #include "ram_internal.h"
@@ -268,7 +269,7 @@ static ssize_t ramoops_pstore_read(struct
pstore_record *record)
  /* ECC correction notice */
  record->ecc_notice_size =3D persistent_ram_ecc_string(prz, NULL, 0);

- record->buf =3D kmalloc(size + record->ecc_notice_size + 1, GFP_KERNEL);
+ record->buf =3D kvmalloc(size + record->ecc_notice_size + 1, GFP_KERNEL);
  if (record->buf =3D=3D NULL) {
  size =3D -ENOMEM;
  goto out;
@@ -282,7 +283,7 @@ static ssize_t ramoops_pstore_read(struct
pstore_record *record)

 out:
  if (free_prz) {
- kfree(prz->old_log);
+ kvfree(prz->old_log);
  kfree(prz);
  }

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 966191d3a5ba..3453d493ec27 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include <asm/page.h>

 #include "ram_internal.h"
@@ -385,7 +386,7 @@ void *persistent_ram_old(struct persistent_ram_zone *pr=
z)

 void persistent_ram_free_old(struct persistent_ram_zone *prz)
 {
- kfree(prz->old_log);
+ kvfree(prz->old_log);
  prz->old_log =3D NULL;
  prz->old_log_size =3D 0;
 }
--




On Mon, Jun 26, 2023 at 11:20=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Jun 26, 2023 at 06:20:29PM -0700, Yuxiao Zhang wrote:
> > @@ -730,7 +731,7 @@ static void decompress_record(struct pstore_record =
*record)
> >   return;
> >
> >   /* Swap out compressed contents with decompressed contents. */
> > - kfree(record->buf);
> > + kvfree(record->buf);
> >   record->buf =3D unzipped;
> >   record->size =3D unzipped_len;
> >   record->compressed =3D false;
> > @@ -783,7 +784,7 @@ void pstore_get_backend_records(struct pstore_info =
*psi,
>
> Patch is corrupted and can not be applied at all, please fix up your
> email client to not do this.
>
> thanks,
>
> greg k-h
