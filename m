Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D13EE49AA
	for <linux-hardening@archiver.kernel.org>; Tue, 22 Aug 2023 03:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjHVDQL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 21 Aug 2023 23:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjHVDQL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 21 Aug 2023 23:16:11 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9347189
        for <linux-hardening@vger.kernel.org>; Mon, 21 Aug 2023 20:16:08 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bca018afe8so1076553a34.0
        for <linux-hardening@vger.kernel.org>; Mon, 21 Aug 2023 20:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1692674168; x=1693278968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6rnVFDEA1BgBA+mUdzjBw9TA8+0/ZjVyvpi44MeCEbk=;
        b=D+i+k3YVcHfIwdFKTK6u+UcarnqVXwgBhW3iKfiT2Zwn1ub4l+WbMH1beEW9Mpqi0Y
         Dtdn/bmO42xhBa7dak0KWbyRJF9QTIc0utQQrOl7sQmHB+ZUoM0OGHssl2GjfXakNqZW
         tDH0zv4298Nk8X8PbVeidqoc7Clz9/Fc2+4dexHUmatT7pRUuRtkqirGnYgzAIx49/Ao
         OpRmVcgize74ORrRKgLFPTwRTfWmKwHmcHVYq9GDPfW++IM3bdRWk0cZRsK4HTyKdKS4
         /gix+jRBJJzXCGW3z5eZGWBUgIFVvFXCZks59GOGGzoKZAHPw0JrS+lzolt4DDoCeNFO
         Oa6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692674168; x=1693278968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rnVFDEA1BgBA+mUdzjBw9TA8+0/ZjVyvpi44MeCEbk=;
        b=mHthM+0MzzLqtISs5teVGhBLVqkkX10guaHsqoxFjgLU02R2iQyJbBarL9Lj9t4LIt
         SC8Jnq0nFiJZbj3Q6rBREJkci9CTYn2A6I0haqXgllzcMSj2QkUxysG61qyiAbeGC6hE
         JH1Wr9TLSmlcj7kNIrs1McEPUWThkyJJhjg25Q8cUjCnlyYd1Aed0MJHeZvdGhrS5a0k
         CGzqxwX/X/BXjEtfLNB6Vmar83A8UpNmToQbuxY/UPymSyIt+x2R2jgKvPhhEijSDgco
         YIhAK6hO9ZHHFR66AOifXyC6+CmUVfluFnXQOV4wZVWrEgohRx3LUyjDMfFHruLw6GvV
         V+wQ==
X-Gm-Message-State: AOJu0Yyih0tn6U2P7S0hHRb6p1uWKs8Np78sPI7nzjG/aPKvym3OnSZ3
        WmZXcfvr04U2loGSnjPqJsmuqw==
X-Google-Smtp-Source: AGHT+IHTu5O309+spg7Mkh7rJrIe7RQpXLqzJH7gxYltD1c18fv1QejjDlS2KcrqmRaICnpgUTVxsw==
X-Received: by 2002:a05:6808:448d:b0:3a7:56a6:bd2b with SMTP id eq13-20020a056808448d00b003a756a6bd2bmr8913866oib.4.1692674168281;
        Mon, 21 Aug 2023 20:16:08 -0700 (PDT)
Received: from cork (c-73-158-249-15.hsd1.ca.comcast.net. [73.158.249.15])
        by smtp.gmail.com with ESMTPSA id p15-20020a637f4f000000b00563590be25esm7050630pgn.29.2023.08.21.20.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 20:16:07 -0700 (PDT)
Date:   Mon, 21 Aug 2023 20:16:05 -0700
From:   =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Uday Shankar <ushankar@purestorage.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Len Brown <len.brown@intel.com>,
        linux-hardening@vger.kernel.org, linux-acpi@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH] Revert "ACPI, APEI, use raw spinlock in ERST"
Message-ID: <ZOQodU1CNMRtjYZ6@cork>
References: <20230822010933.2247671-1-ushankar@purestorage.com>
 <87y1i3c015.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y1i3c015.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 22, 2023 at 09:56:38AM +0800, Huang, Ying wrote:
> 
> ERST is mainly used to log the hardware error.  While, hardware error
> may be reported via NMI (e.g., ACPI APEI GHES NMI), so we need to call
> ERST functions in NMI handlers.  Where normal spinlock cannot be used
> because they will be converted to sleepable rt_mutex in RT kernel.

Non-sleeping spinlocks cannot be used in NMI context either.
raw_spin_lock_irqsave() will prevent regular interrupts, but not NMI.
So taking a spinlock inside an NMI can trigger a deadlock.

Am I missing something here?

Jörn

--
All art is but imitation of nature.
-- Lucius Annaeus Seneca
