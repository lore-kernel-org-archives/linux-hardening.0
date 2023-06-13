Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDF1EB64D8
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jun 2023 20:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjFMURP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjFMURJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jun 2023 16:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEADAA7
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686687387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gY01Tx4BIc89rInz9irLDAvinQyYun0b+aEdVCR03A=;
        b=ICtQYaq0kJ43HwSIRTZ6Mo9zGHhm7IXUk2gIPx3bkr20aKPFaGTwLISsWgNFz1wZKMlUhR
        iic6E6J+82XytuKPJZqaOr8TgWnDQfNjEMwNOD52gFMLV5yPVQ6pm5Tc6gZleuRvk3tOxs
        XaXy9jsJH5yWwnryX6fKIVGM9FfoXmE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-8NyO5kQ7P4intXCpQZbkTQ-1; Tue, 13 Jun 2023 16:16:26 -0400
X-MC-Unique: 8NyO5kQ7P4intXCpQZbkTQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7606a134623so42884085a.1
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 13:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687383; x=1689279383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gY01Tx4BIc89rInz9irLDAvinQyYun0b+aEdVCR03A=;
        b=lkjvocdlVaxK2MWEyJhGHKV40X5DRFEhWZWsJlFI9ureB/rakqCy4pF17P/H6UY2NF
         oF3WIXfumQpZYBFyJE366ET5UaqVD0ZNz/0o603HgN/HXjOl7IrGPeG2OS1b3oUl0mf9
         moSZk+f9+nju5ISZnaNccq+xCnSdGsB4pMDsj8KPyi/jdDvHpywUKIzqOCSzEi1XwR/5
         zv4tZWPHe765bmNW0NElwOFJSO5dX4bb82DsCAC50XjRv7aWauednMYGREGqyxueBRFY
         Eu7TS6VrdmpjXupBrfUZNvgscsHBHYymA79I+8/Bw75cNj0rIV70ZtBkWSjunt0ECdE+
         dchA==
X-Gm-Message-State: AC+VfDzdpNR1xx2BK5mkbQnv0I6yAvVeE/xnNn8ebeJKz4CNTGEdB7ww
        QhvQbt9IFNCa7ynSAohTiOSjiPG6oph80q4feX6OkweV8wXRc9UlXFX22rw7BlS0ZBSSau0lObq
        BzDU1f71xnDKqQyU9ptvyZTH2mz8I
X-Received: by 2002:a05:620a:d96:b0:75e:da20:a10e with SMTP id q22-20020a05620a0d9600b0075eda20a10emr14985494qkl.3.1686687383548;
        Tue, 13 Jun 2023 13:16:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7iLH0WqTagTH32CHBbOR+wl+dP1yrz10MNUnCv37WfCOA1VxEblO4cznoDu1tHw6xJ5PXvag==
X-Received: by 2002:a05:620a:d96:b0:75e:da20:a10e with SMTP id q22-20020a05620a0d9600b0075eda20a10emr14985483qkl.3.1686687383204;
        Tue, 13 Jun 2023 13:16:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c2-20020a05620a164200b00759322a6089sm3843860qko.14.2023.06.13.13.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:16:22 -0700 (PDT)
Date:   Tue, 13 Jun 2023 16:16:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        Liam.Howlett@oracle.com, zhangpeng.00@bytedance.com,
        akpm@linux-foundation.org, koct9i@gmail.com, david@redhat.com,
        ak@linux.intel.com, hughd@google.com, emunson@akamai.com,
        rppt@linux.ibm.com, aarcange@redhat.com,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: inconsistence in mprotect_fixup mlock_fixup madvise_update_vma
Message-ID: <ZIjOlU5EfVNt6NRU@x1n>
References: <CABi2SkWx_BnEHzGqqqbDMJi+vi-5a7XkQUCkyesN5PUtk23SgQ@mail.gmail.com>
 <CABi2SkXw6ZD-M1ZrcXNL7abtM=RzQXv716PPM_k=1Tay=5rUFA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABi2SkXw6ZD-M1ZrcXNL7abtM=RzQXv716PPM_k=1Tay=5rUFA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi, Jeff,

On Tue, Jun 13, 2023 at 08:26:26AM -0700, Jeff Xu wrote:
> + more ppl to the list.
> 
> On Mon, Jun 12, 2023 at 6:04 PM Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > Hello,
> >
> > There seems to be inconsistency in different VMA fixup
> > implementations, for example:
> > mlock_fixup will skip VMA that is hugettlb, etc, but those checks do
> > not exist in mprotect_fixup and madvise_update_vma. Wouldn't this be a
> > problem? the merge/split skipped by mlock_fixup, might get acted on in
> > the madvice/mprotect case.
> >
> > mlock_fixup currently check for
> > if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
> > is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
> > vma_is_dax(vma) || vma_is_secretmem(vma))

The special handling you mentioned in mlock_fixup mostly makes sense to me.

E.g., I think we can just ignore mlock a hugetlb page if it won't be
swapped anyway.

Do you encounter any issue with above?

> > Should there be a common function to handle VMA merge/split ?

IMHO vma_merge() and split_vma() are the "common functions".  Copy Lorenzo
as I think he has plan to look into the interface to make it even easier to
use.

-- 
Peter Xu

