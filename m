Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BB4C77B75
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 01:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjEPBlu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 May 2023 21:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjEPBlt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 May 2023 21:41:49 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C125183
        for <linux-hardening@vger.kernel.org>; Mon, 15 May 2023 18:41:48 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-199bffcfd21so957535fac.1
        for <linux-hardening@vger.kernel.org>; Mon, 15 May 2023 18:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684201307; x=1686793307;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOedSJ17V8iHt8KHOe3xnYUuoXUkebVLJNVs3KstdqI=;
        b=aUHNG7WIgh65aeOq/mwYfz+62LGweoGA/GHSVSaepQsF8GDMGY5iN4EV+lDiTkP6Gy
         UGEVeUcU8hw6rh9Sg2yz0hySRiFvwpx4o19DT9lRfptAnEOo0IzYBnrqHN5w6hTXv8jw
         Xk4owUbp1ktPr+cFzASk8e8UJl+jWZO2bkRWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684201307; x=1686793307;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOedSJ17V8iHt8KHOe3xnYUuoXUkebVLJNVs3KstdqI=;
        b=LPRq1UjtY7NBmi8V3pYYMCPBj+myAqkyYzdBfEuP7DHvEGwFHIyOHUrObDEwm6pzgm
         V41PCCmVIQUEV5qLciUpllRdqYeBtw0Z+reIMb7mtja8G9QAS4+Fss5Xn46LMDgJArMm
         dCT8kCGYRuBHh2QprZWP69qJSka1O7Dy76tUHdgslZFraWkOEyGghVF5Va3VNmR/XLDQ
         98rNsrA8hAh2Ab0Fn+rxc4RCBZrfjjQp/xbgMnuoCWsHKVz2Vila50uA2sq1pcATFENU
         WhgLCzlF33CI41Awzwn7ZjRDtJhZAEpiwP+Q9L+VX/KQLyfsWFzW55kb8mj0Mf+F2gyy
         MOlA==
X-Gm-Message-State: AC+VfDzqrATDf7gFwP7Ni4zEhAL1KYR/he2JnZjDetLF0yP+JC2NFIds
        gkJzw6cmVzmVYz1DSi4h7RNx171hElv3NfoxxzcwNg==
X-Google-Smtp-Source: ACHHUZ6rcT//gO0BfDl+K3mf6a3mSdpI7F1kSMtj1wRAbxCuSDTjM4Co5wJy7waK4krsWK3J03Yy/z+tGlWnJZuPMCs=
X-Received: by 2002:a05:6870:e14e:b0:196:8dc3:4e16 with SMTP id
 z14-20020a056870e14e00b001968dc34e16mr5220391oaa.39.1684201306869; Mon, 15
 May 2023 18:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <CABi2SkXjN+5iFoBhxk71t3cmunTk-s=rB4T7qo0UQRh17s49PQ@mail.gmail.com>
In-Reply-To: <CABi2SkXjN+5iFoBhxk71t3cmunTk-s=rB4T7qo0UQRh17s49PQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Mon, 15 May 2023 18:41:35 -0700
Message-ID: <CABi2SkUfsOWKGdFqgXZg=0AcnUj=AOFb9JmYfp=RwDp_5AcH0Q@mail.gmail.com>
Subject: Re: mprotect outbound check.
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        lstoakes@gmail.com, Liam.Howlett@oracle.com, peterx@redhat.com,
        zhangpeng.00@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

+ Peter, Lian, Lorenzo

Is this related to this hotfix ?
      mm/mprotect: fix do_mprotect_pkey() return on error


Thanks!

-Jeff






On Mon, May 15, 2023 at 11:00=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wrot=
e:
>
> Noticed there is a slight change for mprotect between 6.1 and 6.4 RC1
>
> For example:
> Consider the case below:
> 1 mmap(0x5000000, PAGE_SIZE,  ...)
> 2 mprotect(0x5000000, PAGE_SIZE*4, ...)
>
> in 6.1 and before, 2 will fail, and in 6.4 RC1, it will pass.
>
> I know that munmap will accept out-of-bound cases like this (because
> memory is freed anyway).
>
> Is this change intentional ?
>
> Thanks!
> Best regards,
> -Jeff
