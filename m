Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3BBC433F5
	for <linux-hardening@archiver.kernel.org>; Sat,  8 Oct 2022 23:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJHXGb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 8 Oct 2022 19:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJHXGa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 8 Oct 2022 19:06:30 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A57D2ED76;
        Sat,  8 Oct 2022 16:06:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w2so7923871pfb.0;
        Sat, 08 Oct 2022 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AirYPYi/2kll1AHcM0ztn9kSYL8G4yKhDOoOahy35K0=;
        b=bCl0pRUBoOhiBNuNQ3ecmx+py80LkrsqoQD6nptc01qH0dgmqiWSS5WJj2m+OukRDn
         Ag5n+BFeDqbFuLjYapnKrbjKmRT8IPAkruzZj2EllQjRGmyRqEj52b26wk9r6BknGY3g
         qZn7dbpQ3OIESVqnIjF94ERkp2dpgp2m0hvUhpNAkMvkP14CF3XN8+3HvQENF+mPYIFc
         ewgXYjtiWE8R8Da16baIruk+OM11xeBaHqtD/rgxdBmpEyRitBnpSTwsV7zpzdDVJNf4
         ujm0qE/UVw+LEPMa+FB8e5UsSa9joH6MmjCmRlKNWLGRe7OnCjwQO9iLAfL/eWOdm68k
         cfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AirYPYi/2kll1AHcM0ztn9kSYL8G4yKhDOoOahy35K0=;
        b=cKwINk+sLdh2otVYRW4oMFYPmV7K6dxDnwWrgK46sYcPLhMB6zhH7ReUrcjJnOXYMb
         LuZ94LR1WXTZArys5hvkhz5l0qBfTEEn4fSyjZBYOrhvgSRuAqyb2H7v+rdxt3vZwQy8
         tlPz8JYxFzExeQ+hyRIBoH2t++zl4WYVy6Qs8oDHa7WqnCPYImdjDWmtnfePSY3Fs+ET
         czSaFy3wr1p7NkFOA71l+ZhfcyQ5Riu3QD5XtU0NpRjNzKZFbTnfMPYyi6dx3G+JStYp
         kM3+0P9FbNwTL40SaoX5+pA7sORRse3VtOIb1bX9bXf6XDBYlsUWp5i+f0m7xJgaDv4r
         AAfw==
X-Gm-Message-State: ACrzQf0++cauWSrGZL2bFcEdPtQQNDuBqLQjQndkyecAdxlGH3KmyvxF
        Ks8qFbUqqvUeaxgIXYPdHK0=
X-Google-Smtp-Source: AMsMyM5N354TmScoJU2TEkFjLXkHpfI10flXsPo8lyHL/86uyqw2joTl9L98++PPn9nUbXMKmq0t9Q==
X-Received: by 2002:a63:82c6:0:b0:460:a691:356 with SMTP id w189-20020a6382c6000000b00460a6910356mr2970772pgd.621.1665270388860;
        Sat, 08 Oct 2022 16:06:28 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902784d00b00180a7ff78ccsm2185894pln.126.2022.10.08.16.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 16:06:28 -0700 (PDT)
Date:   Sun, 9 Oct 2022 12:06:21 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH][next] dlm: Replace one-element array with flexible-array
 member
Message-ID: <Y0ICbf8tCtXMn+W0@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

paulo.miguel.almeida.rodenas@gmail.com
Bcc: 
Subject: [PATCH][next] dlm: Replace one-element array with flexible-array
 member
Reply-To: 

One-element arrays are deprecated, and we are replacing them with
flexible array members instead. So, replace one-element array with
flexible-array member in struct dlm_ls, and refactor the rest of the
code, accordingly.

We strive to make changes that don't produce any before/after binary
output differeces as that makes it easier for the reviewer to accept the
patch. In this particular instance, it wasn't possible to achieve this
due to the fact that the ls_name[1] size, which is used as the
NUL-terminator space, was hidden within the struct's padding as shown
below.

$ diff <(objdump -M intel -j .text -D dlm.old) <(objdump -M intel -j
.text -D dlm.new)

13778c13778
<     c693:	49 8d bc 24 c0 08 00 	lea    rdi,[r12+0x8c0]
---
>     c693:	49 8d bc 24 c1 08 00 	lea    rdi,[r12+0x8c1]

$ pahole dlm.old -C dlm_ls
...
	int                        ls_namelen;           /*  2232     4 */
	char                       ls_name[1];           /*  2236     1 */

	/* size: 2240, cachelines: 35, members: 90 */
	/* sum members: 2166, holes: 17, sum holes: 71 */
	/* padding: 3 */
	/* paddings: 3, sum paddings: 17 */
	/* forced alignments: 1 */
} __attribute__((__aligned__(8)));

$ pahole dlm.new -C dlm_ls
...
	int                        ls_namelen;           /*  2232     4 */
	char                       ls_name[];            /*  2236     0 */

	/* size: 2240, cachelines: 35, members: 90 */
	/* sum members: 2165, holes: 17, sum holes: 71 */
	/* padding: 4 */
	/* paddings: 3, sum paddings: 17 */
	/* forced alignments: 1 */
} __attribute__((__aligned__(8)));


This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/228
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 fs/dlm/dlm_internal.h | 2 +-
 fs/dlm/lockspace.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index e34c3d2639a5..ce2e32ed2ede 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -670,7 +670,7 @@ struct dlm_ls {
 	void			*ls_ops_arg;
 
 	int			ls_namelen;
-	char			ls_name[1];
+	char			ls_name[];
 };
 
 /*
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index bae050df7abf..c3a36f3197da 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -473,7 +473,7 @@ static int new_lockspace(const char *name, const char *cluster,
 
 	error = -ENOMEM;
 
-	ls = kzalloc(sizeof(struct dlm_ls) + namelen, GFP_NOFS);
+	ls = kzalloc(sizeof(struct dlm_ls) + namelen + 1, GFP_NOFS);
 	if (!ls)
 		goto out;
 	memcpy(ls->ls_name, name, namelen);
-- 
2.37.3

