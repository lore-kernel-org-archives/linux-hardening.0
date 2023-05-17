Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26812C7EE23
	for <linux-hardening@archiver.kernel.org>; Wed, 17 May 2023 23:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjEQXCR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 May 2023 19:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjEQXCO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 May 2023 19:02:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D2461AD
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 16:02:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae4f28454bso10849485ad.3
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684364526; x=1686956526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCOs9XFCFeYjn/qRnbFLhpqd0QIqRRTHRKO1/+0RAUk=;
        b=hblzA3PbsTRQj6+lS+RlZl1Bd8A+m4ZU2gRkGKogDTW2wJqSkEx6ZBxuNyeQhCXmO/
         7U6aPZGf5+vHz+ckkVvoPkEV42PklylLIZkRyTnzUlpACKLZIomqzSnqlpjZ0O8yve08
         FxK3KLI7abAFw3PZBgAl5IPQmQOw7B7VwPl3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684364526; x=1686956526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCOs9XFCFeYjn/qRnbFLhpqd0QIqRRTHRKO1/+0RAUk=;
        b=AMOtnMCPGwgwdN5Ob5GGhIFywLZCzN0gz5gFMj46XyWqkxkEaT9oeBJ8tHfyCxcqgz
         XAKsDQ2xF+st0g/gqm3qZhkODfRVhYA8/MyGdfSUPypMXsdwNNibFmQY7nZg6UTZtG1G
         EMnBpbQi5vH21xmM7hCeu1Cx2MbhnpkZTociHGdPQFqjdztFHHDRaH/4ye/XpvNI5dkk
         PDqa/riZ+G1MSl7nf8ZUQJ9MEpDE8clUDAD097d+FOP0rGffPDoFQW2AhQTqyavgQIoO
         TQWJtS8RSZ+RfP7PaCSrPA/GGdzZQkZwjSdiuuC6NgmxrqyflL8tTGuCBNo5OzNoOT4W
         e9RA==
X-Gm-Message-State: AC+VfDxS+wtNrLe4qLzzikxeu8hNhRvuOq7pEe0TaLiSmluFoUN1EaXl
        Q3lHy6Yf3HB/9YT4/jNW+eXgDg==
X-Google-Smtp-Source: ACHHUZ7Qe0iBjeZmvcgnaHOBEs733JZVei10a9MeOfdNB6l5X05u502QW9KQ28OgeMcXVjjkg2bwog==
X-Received: by 2002:a17:902:ec8a:b0:19f:87b5:1873 with SMTP id x10-20020a170902ec8a00b0019f87b51873mr342789plg.62.1684364526317;
        Wed, 17 May 2023 16:02:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902728f00b001a69c1c78e7sm18008090pll.71.2023.05.17.16.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 16:02:05 -0700 (PDT)
Date:   Wed, 17 May 2023 16:02:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] scsi: lpfc: Replace one-element array with
 flexible-array member
Message-ID: <202305171602.2C715B078F@keescook>
References: <cover.1684358315.git.gustavoars@kernel.org>
 <6c6dcab88524c14c47fd06b9332bd96162656db5.1684358315.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c6dcab88524c14c47fd06b9332bd96162656db5.1684358315.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 17, 2023 at 03:22:45PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in a couple of structures, and refactor the rest of the code,
> accordingly.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/295
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
