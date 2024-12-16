Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B6207DE4
	for <linux-hardening@vger.kernel.org>; Mon, 16 Dec 2024 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376711; cv=none; b=XfCACBqEDP3zvBnT6XGf5Dh+T9mvXmj4U2KjyF9KbJsza0XMDx3lVEsjNh5HWP+qCO6YahP2WnqVH/w+Crlj+4AyRVa8psWW5W/w0X5AnOq0kx1SnfvUHk1YvFEFwaDrOD3SxurTkDOLylxN0FptvcoCTI0wwUVg/uaabZ/sTKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376711; c=relaxed/simple;
	bh=yP3TzQDLKFngag9zteL/kXhgRK/ewP4UpXB8pYiB3IM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmKm+gQg30Dzdcwo1UEXABdGlVWrxVqgqVlWQ71a+defNK7pmaGMPf5Ix20i8Ji1D9O8Hk+Eij0S4ylTGF8aVt6UVKf1GiQbglbzU0WhNlvEeUGg419/7S8FLuvOJJojWrLJVn3gMl6ncYifHxSD7m9JhIGybdXHDUQUW8/QZ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfieDIws; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfieDIws"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so48019811fa.1
        for <linux-hardening@vger.kernel.org>; Mon, 16 Dec 2024 11:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734376708; x=1734981508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qIkhhjweqlnzre4u5fMNQlUZKG2BC9xxiFTsEQhvHs=;
        b=WfieDIwsC0LAmB34x1dSzVsCfXtDR6ln/U8tPS8wyD3+4WHC/XT8LnDYiAutD3AY87
         R9EHv5ff/FIT6p27i06EQOHBMlKzq1YT2hjMYW7cKMTeGFeKLWi/Tjyvn9bq503qLc9Z
         xGu9oJwh4GWSSys0nNtpZacyw0SmZBDHxafUxsRrvMEqJ52ehVLGl5dlbTPO6XOsrIFb
         Xz1sbweXcwaGM/WsT5sWZPcZBrvdVDHZdAPorAXZJXnBO3RNtC2LbNyAJ7Uy4DZ3NnDC
         6s72G+MFDo1anS+nohp/sXsZediMoUeCihFl43Mwna3/X7A0T5exkTVskgod7I63Ffrx
         QH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734376708; x=1734981508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qIkhhjweqlnzre4u5fMNQlUZKG2BC9xxiFTsEQhvHs=;
        b=WO10euq7s/bguCzsCoqCpJhsdN+oG54XlEf50GcYblP1P/NMmxu5f476h6arLg6yGr
         C3xK2Npoo7Hqp1c21ZtgNpDzhIXwxAxiYfL3f/pPbwEWhoOsXs+vdjbeHfOIKB9bFZ1c
         Z+qUmQTr8ingielpxFCxteE9O878Bp5VD9R/GHVU83ngVtT/whtjVzFYpctZWxxnSFar
         AemwwkjvWTsy8aDTazOAExxU6KYQ8WhVWi2FmhI8GUQyb9/pKX/R5TNczcZTbe4aKasm
         6ZpOu8KWI1CkdIiss0aRnUKCI61aQMaoUBahms8IKfT1O+eTnrl8i3Trq0VYmE2I8hON
         fUiA==
X-Forwarded-Encrypted: i=1; AJvYcCXbNXzugoIEI60JIBkc7oA/JAUqgxIqqUzEV37d1+Ozqn012Eo51819423W81EJQbnVoVqywtT5smc2TdLBEio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuT/7LpmzbUOO6BU3opV4WgJPhSP+S3mp2f05+702RNI5Sy6Co
	Ds8ByriGBiExOewKTD2mKmX40TXU1bG0IDG0zp2xkoMOzMoe1e7X
X-Gm-Gg: ASbGnctD+2t1v8I8F1RS1Bp3j+FHTchqTeetRAtgjgKGvWWCkUxhJbc5H8dszlZfnqi
	B3B0ABAhJFr2Ye5InFmMHVbMhEdBUi3yQtQTbJarqRqmevP8+cPYq3UCwz4xPu855d6+KIzm/tk
	R2WFoGZkyhphBLbGychi2t7oghT3S0AsXSJzkE/cDGtWH4Oq2YuAQQhIE6eE8M85kJux+TXOaDs
	e1T7pm3K12r3TrgC2EZ3YvqMBJtM+lgvw20tbm/42ZSFMVKnv5uonyqbSAjMmaEIFFoD8k2W08u
	jvI=
X-Google-Smtp-Source: AGHT+IGpMpSH+7h0Xrwnrp5NX2sExSdVit7K8OUZuQwEXfC2IsZQlUbaeHsKiWpeRvs+m7n+BJ59NQ==
X-Received: by 2002:a2e:a546:0:b0:302:336a:8ada with SMTP id 38308e7fff4ca-3025459b71fmr45271311fa.27.1734376707481;
        Mon, 16 Dec 2024 11:18:27 -0800 (PST)
Received: from pc636 (host-95-203-7-38.mobileonline.telia.com. [95.203.7.38])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344175ad0sm10140111fa.84.2024.12.16.11.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 11:18:26 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 16 Dec 2024 20:18:24 +0100
To: Matthew Wilcox <willy@infradead.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, zuoze <zuoze1@huawei.com>,
	gustavoars@kernel.org, akpm@linux-foundation.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	keescook@chromium.org
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass
 the vmalloc check.
Message-ID: <Z2B9AMOSgTPboo2U@pc636>
References: <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com>
 <Z08KAupLBo--JGz8@pc636>
 <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com>
 <Z08M88NdLfugqhu9@pc636>
 <d659d925-a322-4566-955a-97894a2aa795@huawei.com>
 <Z08TlFqWVWs47g9z@pc636>
 <Z09VwuhfQbbro-gA@pc638.lan>
 <Z09icnP7QuaLg4Qv@casper.infradead.org>
 <Z1AX-xhOZEZqH1Jw@pc636>
 <Z1-riu65--CviPba@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1-riu65--CviPba@casper.infradead.org>

Hello, Matthew!

> On Wed, Dec 04, 2024 at 09:51:07AM +0100, Uladzislau Rezki wrote:
> > I think, when i have more free cycles, i will check it from performance
> > point of view. Because i do not know how much a maple tree is efficient
> > when it comes to lookups, insert and removing.
> 
> Maple tree has a fanout of around 8-12 at each level, while an rbtree has
> a fanout of two (arguably 3, since we might find the node).  Let's say you
> have 1000 vmalloc areas.  A perfectly balanced rbtree would have 9 levels
> (and might well be 11+ levels if imperfectly balanced -- and part of the
> advantage of rbtrees over AVL trees is that they can be less balanced
> so need fewer rotations).  A perfectly balanced maple tree would have
> only 3 levels.
> 
Thank you for your explanation and some input on this topic. Density, a
high of tree and branching factor should make the work better :)

>
> Addition/removal is more expensive.  We biased the implementation heavily
> towards lookup, so we chose to keep it very compact.  Most users (and
> particularly the VMA tree which was our first client) do more lookups
> than modifications; a real application takes many more pagefaults than
> it does calls to mmap/munmap/mprotect/etc.
> 
This is what i see. Some use cases are degraded. For example stress-ng
forking bench is worse, test_vmalloc.sh also reports a degrade:

See below figures:

<snip>
# Default
urezki@pc638:~$ time sudo ./test_vmalloc.sh run_test_mask=7 nr_threads=64
+   59.52%     7.15%  [kernel]        [k] __vmalloc_node_range_noprof
+   37.98%     0.22%  [test_vmalloc]  [k] fix_size_alloc_test
+   37.32%     8.56%  [kernel]        [k] vfree.part.0
+   35.31%     0.00%  [kernel]        [k] ret_from_fork_asm
+   35.31%     0.00%  [kernel]        [k] ret_from_fork
+   35.31%     0.00%  [kernel]        [k] kthread
+   35.05%     0.00%  [test_vmalloc]  [k] test_func
+   34.16%     0.06%  [test_vmalloc]  [k] long_busy_list_alloc_test
+   32.10%     0.12%  [kernel]        [k] __get_vm_area_node
+   31.69%     1.82%  [kernel]        [k] alloc_vmap_area
+   27.24%     5.01%  [kernel]        [k] _raw_spin_lock
+   25.45%     0.15%  [test_vmalloc]  [k] full_fit_alloc_test
+   23.57%     0.03%  [kernel]        [k] remove_vm_area
+   22.23%    22.23%  [kernel]        [k] native_queued_spin_lock_slowpath
+   14.34%     0.94%  [kernel]        [k] alloc_pages_bulk_noprof
+   10.80%     7.51%  [kernel]        [k] free_vmap_area_noflush
+   10.59%    10.59%  [kernel]        [k] clear_page_rep
+    9.52%     8.96%  [kernel]        [k] insert_vmap_area
+    7.39%     2.82%  [kernel]        [k] find_unlink_vmap_area

# Maple-tree
time sudo ./test_vmalloc.sh run_test_mask=7 nr_threads=64
+   74.33%     1.50%  [kernel]        [k] __vmalloc_node_range_noprof
+   55.73%     0.06%  [kernel]        [k] __get_vm_area_node
+   55.53%     1.07%  [kernel]        [k] alloc_vmap_area
+   53.78%     0.09%  [test_vmalloc]  [k] long_busy_list_alloc_test
+   53.75%     1.76%  [kernel]        [k] _raw_spin_lock
+   52.81%    51.80%  [kernel]        [k] native_queued_spin_lock_slowpath
+   28.93%     0.09%  [test_vmalloc]  [k] full_fit_alloc_test
+   23.29%     2.43%  [kernel]        [k] vfree.part.0
+   20.29%     0.01%  [kernel]        [k] mt_insert_vmap_area
+   20.27%     0.34%  [kernel]        [k] mtree_insert_range
+   15.30%     0.05%  [test_vmalloc]  [k] fix_size_alloc_test
+   14.06%     0.05%  [kernel]        [k] remove_vm_area
+   13.73%     0.00%  [kernel]        [k] ret_from_fork_asm
+   13.73%     0.00%  [kernel]        [k] ret_from_fork
+   13.73%     0.00%  [kernel]        [k] kthread
+   13.51%     0.00%  [test_vmalloc]  [k] test_func
+   13.15%     0.87%  [kernel]        [k] alloc_pages_bulk_noprof
+    9.92%     9.54%  [kernel]        [k] clear_page_rep
+    9.62%     0.07%  [kernel]        [k] find_unlink_vmap_area
+    9.55%     0.04%  [kernel]        [k] mtree_erase
+    5.92%     1.44%  [kernel]        [k] free_unref_page
+    4.92%     0.24%  [kernel]        [k] mas_insert.isra.0
+    4.69%     0.93%  [kernel]        [k] mas_erase
+    4.47%     0.02%  [kernel]        [k] rcu_do_batch
+    3.35%     2.10%  [kernel]        [k] __vmap_pages_range_noflush
+    3.00%     2.81%  [kernel]        [k] mas_wr_store_type
<snip>

i.e. insert/remove are more expansive, at least my test show this.
It looks like, mtree_insert() uses a range_variant which implies
a tree update after an insert operation is completed. And probably
where an overhead comes from. If i use a b+tree(my own implementation),
as expected, it is better than rb-tree because of b+tree properties.

I have composed some data, you can find more bench data there:

wget ftp://vps418301.ovh.net/incoming/Maple_tree_comparison_with_rb_tree_in_vmalloc.pdf

>> That's what maple trees do; they store non-overlapping ranges.  So you
>> can look up any address in a range and it will return you the pointer
>> associated with that range.  Just like you'd want for a page fault ;-)
Thank you. I see. I though that it also can work as a regular b+ or b
tress so we do not spend cycles on updates to track ranges. Like below
code:

int ret = mtree_insert(t, va->va_start, va, GFP_KERNEL);

i do not store a range here, i store key -> value pair but maple-tree
considers it as range: [va_start:va_start]. Maybe we can improve this
case when not a range is passed?

This is just my thoughts :)

--
Uladzislau Rezki
