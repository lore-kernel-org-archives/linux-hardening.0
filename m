Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FDDC7EE2F
	for <linux-hardening@archiver.kernel.org>; Fri, 26 May 2023 17:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbjEZRmY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 26 May 2023 13:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242720AbjEZRmX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 26 May 2023 13:42:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60354E65
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 10:42:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d24136663so910227b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685122920; x=1687714920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzkLCtK6sSR84gGu0pHUyFqZuhAc6wVW3zGt3fCHd8A=;
        b=QT6t4K12P7rnXTLcm5Lx1LIZR1MPJa9FlTsCngYetkrHw3sW46rIqrAG1AFjR8sWb6
         kIvHb3q2cPGCw6h3OkWVbOiBxVeSEpSTqOqfM+xcIz7QH+jBL8MQ9P0vdtnqEraXN+Yt
         QJqA79OMHWrFkJtTGNVC03Dm7r4+gPEB2HJnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685122920; x=1687714920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzkLCtK6sSR84gGu0pHUyFqZuhAc6wVW3zGt3fCHd8A=;
        b=Uhg49VwWuX3AIeYT3RDoLWok/YR4yGXyBl7wmilvmnqNKWFJDLMe7yXcRI1SxZ/uFJ
         MtJvTF2nJsZVgMy+dKb9I8TjPiARu7XopvFk9FC1wlZ+7Z3KBPleyYrAgRbKSqaPmTNh
         b6LG6UI1f/r2SxPuysv6w2+sxpbyndU6M7ns37M0dJWp2KMqm0UHM5eofnq8zFp0sjbZ
         8lhavwifOPcQWox2GfcizttYpTN/fkj6tvLznc/w2OhuhOTY8QM+IuAVV7AyJyfttM1e
         07bZ3wo4t1iZWOvzEsZR8yK77a1vlh/unJ16MiEC2WxFJqFxAGcZJ04Lsq6lfb+egqS+
         oICQ==
X-Gm-Message-State: AC+VfDxvP701jctngDcSWweCsPkXJJZTN5KAoRc3F9cb6g3wE4pgnwLe
        C5JKfdT4g7lDJTYBP/hywrDF1w==
X-Google-Smtp-Source: ACHHUZ7p9OpMzdYLLWHwtPA3GpWN9Mb1f0Jb0YPuUcHlrUWjMSB7QL9tkgbq8shEv5eS5UX10tipJA==
X-Received: by 2002:a05:6a00:98e:b0:64a:c673:d064 with SMTP id u14-20020a056a00098e00b0064ac673d064mr4744620pfg.17.1685122920652;
        Fri, 26 May 2023 10:42:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n17-20020aa78a51000000b0064389eab4c8sm2947098pfa.126.2023.05.26.10.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:42:00 -0700 (PDT)
Date:   Fri, 26 May 2023 10:41:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Tee <justintee8345@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Tee <justin.tee@broadcom.com>
Subject: Re: [PATCH v2][next] scsi: lpfc: Use struct_size() helper
Message-ID: <202305261041.4C23B96F@keescook>
References: <ZG0fDdY/PPQ/ijlt@work>
 <CABPRKS9ykHvaOGUboDXZ261LLPS78+YFpOZAcJEeLKGfEUe21g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPRKS9ykHvaOGUboDXZ261LLPS78+YFpOZAcJEeLKGfEUe21g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 23, 2023 at 10:25:20PM -0700, Justin Tee wrote:
> no_of_objects may be hardcoded to 1 right now, but does it make more
> sense to use?
> 
> struct_size(rap, obj, be32_to_cpu(rap->no_of_objects));

Oh yeah, that's nicer. :)

> We probably should have declared no_of_objects as __be32 to have
> avoided this confusion.

Perhaps this patch can add that too?

-- 
Kees Cook
