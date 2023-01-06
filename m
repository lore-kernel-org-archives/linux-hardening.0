Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3D1C63797
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Jan 2023 20:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbjAFUfn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbjAFUfE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Jan 2023 15:35:04 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9946EC86
        for <linux-hardening@vger.kernel.org>; Fri,  6 Jan 2023 12:34:58 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id fz16-20020a17090b025000b002269d6c2d83so6563789pjb.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Jan 2023 12:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=smLihWAoqAqFbknhrZe9gcdfzxiLxKROgu0edof4WNI=;
        b=XTWSKfx3nZLz4qPLToGFL8BRLfDjJeeRpHAPv1wqntQQBJJ7SpBBti7/NgGA745P9o
         VrT68aF/TOwlmXWmpartLpvQqjI1pBThoa6QjJq5VpThBJm+mjeYZcd/t8anZIUAtbpI
         BtSczITxJaiaqItBa3WuILOt9wgSAsJxysMoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smLihWAoqAqFbknhrZe9gcdfzxiLxKROgu0edof4WNI=;
        b=lE9/2V37ts8D6ud7ctHYRMhyG98wTGeA8nsqrX2C2TrlbDa1Sv6UWwKPXO4CTumV4R
         MIxAXEfdX/Zp0x73OBYs1GHyzGqDyJR2vplGQMtNVJXDsHz+nnii/eLcfrzmhUR34LNc
         3xcZcY/SXMOT4sCYWOhfzlRWD7NKrjSPo0VcIuxH8y8bgRqRP0kkVQE+r290CFpiNJpE
         3TC+Un9ZYViOq9/Bzqub6X7TzaYQUxcVPK2j02ovBJNFPkNPuo8ulXCbANg5WFLINuZp
         M4Lz/tqqJPjqwpqYr63alNoeiHQjY5JF3QqgKfRBNWm47LC8YB6RssBcik53ArE5/DAD
         lTDQ==
X-Gm-Message-State: AFqh2koLhdhB6paasYob/vgKDfnW7lDodzLm2x+re1XWGIqLK0xfWKce
        HT+paFMAUQ+U6E0Mk/8Ujr2BWg==
X-Google-Smtp-Source: AMrXdXsdMkFkNgHrTqmp5sajKoSVuShvjmPCPLLKswdGxixWwb9SOACATFN7VsWOKUoikzRE6j2XVw==
X-Received: by 2002:a17:90a:d306:b0:219:f385:33a9 with SMTP id p6-20020a17090ad30600b00219f38533a9mr59906578pju.27.1673037297533;
        Fri, 06 Jan 2023 12:34:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r13-20020a17090a940d00b0020dc318a43esm1302623pjo.25.2023.01.06.12.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:34:54 -0800 (PST)
Date:   Fri, 6 Jan 2023 12:34:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] firmware: coreboot: Check size of table entry and split
 memcpy
Message-ID: <202301061234.D15CF0E627@keescook>
References: <20230106045327.never.413-kees@kernel.org>
 <CAODwPW8kXZ107kMuVGya9Y=i+8QwQzQHokXCpybzMBjd_w_83w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODwPW8kXZ107kMuVGya9Y=i+8QwQzQHokXCpybzMBjd_w_83w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 06, 2023 at 04:03:35PM +0100, Julius Werner wrote:
> Have you considered adding the flexible array member directly to the
> union in struct coreboot_device instead? I think that would make this
> a bit simpler by not having to copy header and data portion
> separately.

Are you thinking something like this?


diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 2652c396c423..564a3c908838 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -93,14 +93,19 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
 	for (i = 0; i < header->table_entries; i++) {
 		entry = ptr_entry;
 
-		device = kzalloc(sizeof(struct device) + entry->size, GFP_KERNEL);
+		if (entry->size < sizeof(*entry)) {
+			dev_warn(dev, "coreboot table entry too small!\n");
+			return -EINVAL;
+		}
+
+		device = kzalloc(sizeof(device->dev) + entry->size, GFP_KERNEL);
 		if (!device)
 			return -ENOMEM;
 
 		device->dev.parent = dev;
 		device->dev.bus = &coreboot_bus_type;
 		device->dev.release = coreboot_device_release;
-		memcpy(&device->entry, ptr_entry, entry->size);
+		memcpy(device->raw, entry, entry->size);
 
 		switch (device->entry.tag) {
 		case LB_TAG_CBMEM_ENTRY:
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index 37f4d335a606..d814dca33a08 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -79,6 +79,7 @@ struct coreboot_device {
 		struct lb_cbmem_ref cbmem_ref;
 		struct lb_cbmem_entry cbmem_entry;
 		struct lb_framebuffer framebuffer;
+		DECLARE_FLEX_ARRAY(u8, raw);
 	};
 };
 

-- 
Kees Cook
