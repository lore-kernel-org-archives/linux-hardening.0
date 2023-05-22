Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63B9C77B73
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 19:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjEVTGo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjEVTGn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 15:06:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C3A7;
        Mon, 22 May 2023 12:06:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d18d772bdso5672176b3a.3;
        Mon, 22 May 2023 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684782402; x=1687374402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXUOmQaA/PPc5IVqYPZz5n5b6S9sKOGW6rscflhON08=;
        b=hTbbdrwFwiFBdH81qUA0luS3Ov5aNfJ0TVKQBneaz5wRyqeQljOfzzMMXNKu7h/5cN
         sAH2etANRA53oFmkUKNfmR4BlZe0ScKlLvn0m1Xkpr6LrvQ0gLX9BPsnV+sRGbDkOMwk
         idJBYBj+8YAYL6Nb/K6mn4aMNHAG6dPI1QQs+fH65X5K4buppSq4G5fEDLEnVLt6cO+R
         1BXD5j+xBttLKonHkqVMfvR1btd3+jHA7lx415wbemH5UZRZGP5LESKci6AXAHlUvYVz
         W9sYnC9SnqYrmy7OJdW9cOLBQLJwVATEDTB5oFfVg4+OU0gS5GMUa3BlDCnXXQ9RqVDJ
         lANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684782402; x=1687374402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXUOmQaA/PPc5IVqYPZz5n5b6S9sKOGW6rscflhON08=;
        b=X35WdXI0y1sDwJxWMvVctEdSOlEOgVHheD1WsnXVhuobPWXKDT6b8hEmY0C21hqM6d
         2XB5vWoyTUvnDLI3JAlrDun2N+pdpET+lTbFbDBI7/KaMypi/oCM8fRDg0//dL5cz0Hs
         QOo8ROeOOCJv5BU1mBMORqvscjMB9ht3Vk+dIPdlH2my3SumU1gCcvlFB+AddqHG9WkZ
         0mi9ir9W3uuBPpM/xJ/PGIyWSWldfSKZmW0ueXANHIf59IELQdxLBUjC/bODApVtZgHr
         9RoiSygQF6wyjJiKnZC1QXZvazvE07flLkaa1QvbMOPLUt8FDn/7E8Dj9aO2PL8tO0hM
         s0Sw==
X-Gm-Message-State: AC+VfDz4+uO4fszoSkndwOBtfuP80sX+dgNGTHpgnDFm6VeF/BlDtzph
        0hUIE5095LZR527b8GBI5Gs=
X-Google-Smtp-Source: ACHHUZ4GU5SA+Fmx2f2bxL68/1TKbnLnfJhvsHKH+Z03SxrVDMq4mMWnQK2fs8n2Yt5QUKk+XO/guA==
X-Received: by 2002:a05:6a00:2d28:b0:64a:f730:154b with SMTP id fa40-20020a056a002d2800b0064af730154bmr14128008pfb.5.1684782401850;
        Mon, 22 May 2023 12:06:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:39c])
        by smtp.gmail.com with ESMTPSA id fe21-20020a056a002f1500b0064d47cd117esm4186288pfb.39.2023.05.22.12.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:06:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 22 May 2023 09:06:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-hardening@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Replace all non-returning strlcpy with strscpy
Message-ID: <ZGu9P6tqcGIeVD_x@slm.duckdns.org>
References: <20230517144910.1521547-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517144910.1521547-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 17, 2023 at 02:49:10PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Applied to cgroup/for-6.5.

Thanks.

-- 
tejun
