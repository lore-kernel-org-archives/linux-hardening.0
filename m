Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7094C7EE24
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 23:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjEPXjy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 19:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjEPXjx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 19:39:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB13527C
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 16:39:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f423c17bafso16145e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 16:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684280389; x=1686872389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVbScJsRYo9C8gkT6czO0nTA247xNQRGalDUa94EESY=;
        b=rAsLis5Y3Mdq3fZxLBr6Ca0RO0vz0Gkzk8RCL2v9vLJHKTkW/+MdQXeDqHAFwN34KM
         c0ax5LGreSUOwVtsQIEfQ8v0yRszOR3m73CJKIIY+2jbxTreoCEozvFaFINhdMz1kUyi
         myPgquXon0K3WyUmRzWUfJpZeDdFs4PdKILf4Dj/doPIJvE0a5Z+Bht2VHU+112WGnLI
         9k5Re56g5wwro9pctcr5tmWFikkn3SU06EYMLK3e7jV/+/jHDwxMj92hnEmwo8hBD32m
         3B7wbdkrrD9OhyN29J/eHPJF+CabK3s4fWUAC8Nul+I8Oe+zLdUOsIVjLKj9L4zNZPTR
         Dg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684280389; x=1686872389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVbScJsRYo9C8gkT6czO0nTA247xNQRGalDUa94EESY=;
        b=OnHuQXj0zZXQcBW2SqUXNIbSpkutknZOnx/qXOetS5J+veZLoO4HKlIgIr5rZe8eEa
         TELf2Yvxyv2XKlm9SwDE3ZbEO5GjMLe2PHGRLeR5Z9IWR/ijcr7n0BgZY9Z1HYVSfJMI
         SRheZOTZqkHCUrT0ySz6k7l3ZWiUIUe5z2+KB4dGRetJ3Bu844GSEx2p/tXgfslO0h6Y
         QL5/I9/mJaOGIKDxGkTB3TRw2to21hk2uAiYjRGItSuzr6ZCmysHJXXGh4LhZ2SMufwG
         wGstp19FLJ0eCay6hV3vyU6Sqnup1JwFBkhj28RmurKBraHltC/ZXzG9mcJhukcRv02s
         hGRQ==
X-Gm-Message-State: AC+VfDxXTEqZyeqUnKECfgqqkKw3VuusbkxsyaVbvNJ6KF9n3OMtuFT8
        bYySlI8gpy/X+LaSFxxz67W0tG1rezjHjfl8xIY9AQ==
X-Google-Smtp-Source: ACHHUZ7RclDA07s2LmZ5quWcJhAyYC1M9Rvbz3x6pnOAsWZ2ONZ6exAsXWwFG979R7GurPzNMvNVQJAdM/7t1qsNBGA=
X-Received: by 2002:a05:600c:3584:b0:3f5:f63:d490 with SMTP id
 p4-20020a05600c358400b003f50f63d490mr27707wmq.5.1684280389419; Tue, 16 May
 2023 16:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <202305161307.4A16BB6A47@keescook>
 <CALmYWFteCd+h+tn+LmgTpN9Ld5=qAMMQ34=b1KCoE3OSBun+DQ@mail.gmail.com> <1656e926-f277-710e-71ad-1ff2fe77886b@intel.com>
In-Reply-To: <1656e926-f277-710e-71ad-1ff2fe77886b@intel.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 16 May 2023 16:39:12 -0700
Message-ID: <CALmYWFsLx2CAwW5nWOC_sC4i6kYmRJQ0o8fiArXhozycsAoShA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, jeffxu@chromium.org,
        luto@kernel.org, jorgelo@chromium.org, groeck@chromium.org,
        jannh@google.com, sroettger@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 16, 2023 at 3:30=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/16/23 15:17, Jeff Xu wrote:
> >>> This set of patch covers mprotect/munmap, I plan to work on other
> >>> syscalls after this.
> >> Which ones are on your list currently?
> >>
> > mprotect/mprotect_pkey/munmap
> > mmap/mremap
> > madvice,brk,sbrk
>
> What about pkey_free()?
>
> Without that, someone can presumably free the pkey and then reallocate
> it without PKEY_ENFORCE_API.
>
Great catch. I will add it to the list.
Thanks!
-Jeff Xu

>
