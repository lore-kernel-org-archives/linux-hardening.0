Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A35EB64DB
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Jun 2023 12:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjFNM6L (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Jun 2023 08:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjFNM6K (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Jun 2023 08:58:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AA810DA;
        Wed, 14 Jun 2023 05:58:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCC6D6363C;
        Wed, 14 Jun 2023 12:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4C3C433C0;
        Wed, 14 Jun 2023 12:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686747487;
        bh=ARyKFKyAQ4+Tskav+UjOL70NYKP30fjk7d+NNv9YBkE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=RtC5+NubFNMCdMH9tY/glGMEhV2jEw6VdetqDTjN6fBVqaTKKAYY8Z99AoZ1O9khI
         WzEIAcbLOiGR+RwsiceFy0MmKFHY2hoouOjM2qSmnW7QPGZ8rVbx90eUpg8hR0soVX
         k/PwK3/JYXunSo/l1FgBr8OsRQDlqoB5PhoKdADRACYO/KaO//IC5Y1l3oVo5ypfcN
         zfAkdLJcLDwIAm+TiMyDcmNlKxwySYx9we3s8u9e/NAeF0BmQQDwhoFGuPymRdnnwT
         C4nTBDSj1oYD8Euis/wyz0VjrYa+meJGa7psExl42Tm+4JztGvp0orscg4S6VKlA5h
         faqv2TaFPhS3A==
Date:   Wed, 14 Jun 2023 15:57:31 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Peter Xu <peterx@redhat.com>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        zhangpeng.00@bytedance.com, akpm@linux-foundation.org,
        koct9i@gmail.com, david@redhat.com, ak@linux.intel.com,
        hughd@google.com, emunson@akamai.com, rppt@linux.ibm.com,
        aarcange@redhat.com, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: inconsistence in mprotect_fixup mlock_fixup madvise_update_vma
Message-ID: <20230614125731.GY52412@kernel.org>
References: <CABi2SkWx_BnEHzGqqqbDMJi+vi-5a7XkQUCkyesN5PUtk23SgQ@mail.gmail.com>
 <CABi2SkXw6ZD-M1ZrcXNL7abtM=RzQXv716PPM_k=1Tay=5rUFA@mail.gmail.com>
 <ZIjOlU5EfVNt6NRU@x1n>
 <CABi2SkXE4pUhHucZ_c-_4Ux-VcLKic0+HY_DN2wUEC6DGkDvQQ@mail.gmail.com>
 <20230614011814.sz2l6z6wbaubabk2@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230614011814.sz2l6z6wbaubabk2@revolver>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 13, 2023 at 09:18:14PM -0400, Liam R. Howlett wrote:
> * Jeff Xu <jeffxu@chromium.org> [230613 17:29]:
> > Hello Peter,
> > 
> > Thanks for responding.
> > 
> > On Tue, Jun 13, 2023 at 1:16 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > Hi, Jeff,
> > >
> > > On Tue, Jun 13, 2023 at 08:26:26AM -0700, Jeff Xu wrote:
> > > > + more ppl to the list.
> > > >
> > > > On Mon, Jun 12, 2023 at 6:04 PM Jeff Xu <jeffxu@chromium.org> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > There seems to be inconsistency in different VMA fixup
> > > > > implementations, for example:
> > > > > mlock_fixup will skip VMA that is hugettlb, etc, but those checks do
> > > > > not exist in mprotect_fixup and madvise_update_vma. Wouldn't this be a
> > > > > problem? the merge/split skipped by mlock_fixup, might get acted on in
> > > > > the madvice/mprotect case.
> > > > >
> > > > > mlock_fixup currently check for
> > > > > if (newflags == oldflags ||
> 
> newflags == oldflags, then we don't need to do anything here, it's
> already at the desired mlock.  mprotect does this, madvise does this..
> probably.. it's ugly.
> 
> > > > > (oldflags & VM_SPECIAL) ||
> 
> It's special, merging will fail always.  I don't know about splitting,
> but I guess we don't want to alter the mlock state on special mappings.
> 
> > > > > is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
> > > > > vma_is_dax(vma) || vma_is_secretmem(vma))
> > >
> > > The special handling you mentioned in mlock_fixup mostly makes sense to me.
> > >
> > > E.g., I think we can just ignore mlock a hugetlb page if it won't be
> > > swapped anyway.
> > >
> > > Do you encounter any issue with above?
> > >
> > > > > Should there be a common function to handle VMA merge/split ?
> > >
> > > IMHO vma_merge() and split_vma() are the "common functions".  Copy Lorenzo
> > > as I think he has plan to look into the interface to make it even easier to
> > > use.
> > >
> > The mprotect_fixup doesn't have the same check as mlock_fixup. When
> > userspace calls mlock(), two VMAs might not merge or split because of
> > vma_is_secretmem check, However, when user space calls mprotect() with
> > the same address range, it will merge/split.  If mlock() is doing the
> > right thing to merge/split the VMAs, then mprotect() is not ?
> 
> It looks like secretmem is mlock'ed to begin with so they don't want it
> to be touched.  So, I think they will be treated differently and I think
> it is correct.

Right, they don't :)

secretmem VMAs are always mlocked, they cannot be munlocked and there is no
point trying to mlock them again.

The mprotect for secretmem is Ok though, so e.g. if we (unlikely) have two
adjacent secretmem VMAs in a range passed to mprotect, it's fine to merge
them.
 
> Although, it would have been nice to have the comment above the function
> kept up to date on why certain VMAs are filtered out.
> 
> > 
> > Also skipping merge of VMA might be OK, but skipping split doesn't,
> > wouldn't that cause inconsistent between vma->vm_flags and what is
> > provisioned in the page ?
> 
> I don't quite follow what you mean.  It seems like the mlock_fixup() is
> skipped when we don't want the flag to be altered on a particular VMA.
> Where do they get out of sync?
> 
> 

-- 
Sincerely yours,
Mike.
