Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A18EB64D0
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jun 2023 15:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbjFMP0k (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jun 2023 11:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbjFMP0j (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jun 2023 11:26:39 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEEC19B1
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 08:26:38 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1a670ac3650so2512463fac.1
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686669997; x=1689261997;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sP5idTvIDCNhphFxgMYPrqA/v5X6PDGt+hLyjhHCuqc=;
        b=l33Kcibkx3maWuZGuU6K37uh3DEojYwaVDf/g/Fb7RX90PfwCiHwEjBIqfI9qzRFxF
         wx8oO4o7PNhBPw3C7eia6LgEALKqi7chYkMHYHQOl8RWFhvdK9hyUdvGFpRjPJSY56H/
         L6zSuEgRgahgnb3Q0BJEP/I7jlOE/wIDajstk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686669997; x=1689261997;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP5idTvIDCNhphFxgMYPrqA/v5X6PDGt+hLyjhHCuqc=;
        b=k61TJTcaU9CyRFSjX0X1vUdSIk5Qc0/asbh23pazJeHbGdmyOl91RFhEhDZxw2MUxY
         ZvAJDVUEJGQryhlJxeCtAMxFT9n4Slie3o3y3ZdKF+Wct3yxDMIzOyy4wN+fn0zugT3o
         4NVIwgBLlRok1KattNKzchEIyYT7l4bkLzP10SME3eoIwsex4aOBXJ3CmK03t+JjfmyG
         2kVe6E2g9u/VvcuQ//Dx+MtDPcnxY4aQP0mAIBSF0pfvcK+p4fR6vltjbshRZluuPodx
         TtzI51YVGOsomIcIkH/8eK0DZISvpjVRKJb1+KoxWfsIz0IwSK4iHuA2gXXaXM9dH4x/
         TLbw==
X-Gm-Message-State: AC+VfDw2z8RO4iD4fJGpzjcApPDaXt2BmIVCEfIJtswyuu53cwnQm6fZ
        VjQMc8JSvoGk/tHx3xM6ZFU7ma2j2yMW9aep/mPVYA==
X-Google-Smtp-Source: ACHHUZ6fWfqaRgyeuAlfhObZcz+fl/jaJIo8cHxCVuOOLS2LfFbaG61hvKxfM+YFR8TTX3pD36RCVkmrqUha7HxHk/g=
X-Received: by 2002:a05:6870:e905:b0:19a:2178:ee94 with SMTP id
 l5-20020a056870e90500b0019a2178ee94mr9499419oan.26.1686669997691; Tue, 13 Jun
 2023 08:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <CABi2SkWx_BnEHzGqqqbDMJi+vi-5a7XkQUCkyesN5PUtk23SgQ@mail.gmail.com>
In-Reply-To: <CABi2SkWx_BnEHzGqqqbDMJi+vi-5a7XkQUCkyesN5PUtk23SgQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Tue, 13 Jun 2023 08:26:26 -0700
Message-ID: <CABi2SkXw6ZD-M1ZrcXNL7abtM=RzQXv716PPM_k=1Tay=5rUFA@mail.gmail.com>
Subject: Re: inconsistence in mprotect_fixup mlock_fixup madvise_update_vma
To:     linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        Liam.Howlett@oracle.com, peterx@redhat.com,
        zhangpeng.00@bytedance.com, akpm@linux-foundation.org,
        koct9i@gmail.com, david@redhat.com, ak@linux.intel.com,
        hughd@google.com, emunson@akamai.com, rppt@linux.ibm.com,
        aarcange@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

+ more ppl to the list.

On Mon, Jun 12, 2023 at 6:04=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> Hello,
>
> There seems to be inconsistency in different VMA fixup
> implementations, for example:
> mlock_fixup will skip VMA that is hugettlb, etc, but those checks do
> not exist in mprotect_fixup and madvise_update_vma. Wouldn't this be a
> problem? the merge/split skipped by mlock_fixup, might get acted on in
> the madvice/mprotect case.
>
> mlock_fixup currently check for
> if (newflags =3D=3D oldflags || (oldflags & VM_SPECIAL) ||
> is_vm_hugetlb_page(vma) || vma =3D=3D get_gate_vma(current->mm) ||
> vma_is_dax(vma) || vma_is_secretmem(vma))
>
> Should there be a common function to handle VMA merge/split ?
>
> Best
> -Jeff
