Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABA3002D8
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854366; cv=pass; b=sYXT7Xnddzg8Cohl5MwSXiUM0+kAmHXLulPE7nNrpdvn9RsKHW7tCSEe8k0wQuI117MZWp7i1pKC+mTgTskvRstFJU/wQ5sAVxprkJEZII3Hu+m3NlomRu6pZgf1TvZbzjwWQy0qF49Xsd+PhijidEz6M3tKLONVK0m3TVDfMXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854366; c=relaxed/simple;
	bh=dWRxdLAGRYDInZQY6B2Sfv9PCyvW0LxwPrpwXkjDOU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eO/aTpwepOKov2qsMO3NZr6LrC8rAEDhq1L7AYnw4Hr894chk0wHhjdE/PFVMsqaUoJVLq/fcUYA4XC4/oSexxVRK0SkjW9FtF6zRWdHmD0b0tRgaCw4OX/L5mFeC6twNOitPG9XqOpokIAp36vKCvQnDrUMjg8TTqI7Z78zj0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eigdC/2z; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eigdC/2z"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30b6dad2382so3442965eec.0
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 00:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781854363; cv=none;
        d=google.com; s=arc-20240605;
        b=dsQWCjoXnXP8jTRz8usrsO8N323/Z+0Qt8b7VcIKMPxa5QYCCvILu0RkVnv49tEQC6
         nL3BCeplh7YfYpXwLYyz/jICbQL6q4BSDgtOgcWqIadmXuCya5ZxX1oihaPpQzI20vst
         ltedNUBUMQhL36C83y3I4jRqTyOsxKk999zZoqZrNckLUt7NUgIwYGHBpj8MPOJhvzvG
         udqISfAf1cNIWzCym6ADz75iPsd1oLn9KOYolguOjdpaPSPe6/zexGY8H39yInVCF2OB
         Hoii5oJiaK4MFAvKPMLP91Xh8nCo9syqe+FiOZpYWuuB7nSCW989l/AW9pZBQ+8MJg1R
         RsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5iyHnmV1Idu5SaKyMCT5H/JITEJhxNn6+mUdwznI+7U=;
        fh=UhrXcPVT852V2GjLiwymafsuB42DCkPnLjc1r7DOFek=;
        b=k/n/cZ8ZbXDcOyjfIJUqSIGyAHtsR1k64MQrEFubirnFATMzuclwt2kt9yCKM/rlVo
         6WFz8X8af6Jf3gPg3VIqNc251e8Se7hGOOGioIMFB5907DrFZINJukjbIcOFkKD5SDvS
         MaAQuOxqc3AS/0JCeziWQaKhU/AkBMtc8tkOJDFFecyWHbTrtBcbUztIa1S+HjhNieHC
         pf6l4wWQtfeGyhVZEd6hHV2vUri0wOL/B44JtNjTyIPm4XL7i4ZwuxT243vwp1brfZgT
         GOznLq1dZfiyb2r++nMbHG99r9dV8q0K+zcYBa61mYze1ODVhSdAUhQ45hscrUA0gMVu
         3TwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781854363; x=1782459163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5iyHnmV1Idu5SaKyMCT5H/JITEJhxNn6+mUdwznI+7U=;
        b=eigdC/2z6EEQipKS6sexR2vhZ1AyXxBupCpC44h5uATvukhMSASnR8F2FGx518c+Z/
         T86pr+b0BZJdJ4QSRsNxMHBIbeXVJ10x7hexFC5D9ntMLkc5GmYWVJhTnzUW/c+g4sMi
         7w2OWZaSoDsytvh/BCff9q3kXLBCYMlEBwxT00V40amhtvmxM7ztYSyjpRNfT/tJ0CJC
         ybQu0OH7LtR3XqaiR+kqv+LcSRt7RyVXGwaDPJvAI77p1sfjsAQ0dcsb9n+BZr/prCrm
         1zFnm7cvPKW82DidKlVnxK6QezVOOfdAfTXePGXuugYtjM/O2nhIwQFGodjFABLWHTLn
         llWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781854363; x=1782459163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iyHnmV1Idu5SaKyMCT5H/JITEJhxNn6+mUdwznI+7U=;
        b=BPj2SUQeXOUAL7twXJuhMEr+Kz0tXEF80rBMqCEnxRZpBjp0P3cAIs0Zuwvg3B/RGk
         H3G92TK/PMictbviviibRcjvH36RdTi69Ft2vP3N1RPAtm0YHkWYGM01moM3lZ8Z6gwO
         u1CTdxJC+Voch4jm4alKVlU6QHdkHIcZdDcC7/Mnv4RqAQn5X5+ZgyfVyC2pTQbrfkof
         S4emcu0hwmgmP+zjq2d+VV70yyTbxzaK1m4gqvhdlqiLcuyNaA9/FWeFqMA7jcXqcXbP
         BF/rYcawmOlhwYUbqwjBU4f49I7zOoevRA7H0D5GVh5fAFo7oF3na+j4Pj9ONqGKJFic
         bf/A==
X-Forwarded-Encrypted: i=1; AFNElJ8vBS8GCNV3m8E8Mcmtosud4mM8I0ioAQ7p9qglFX+q1236fOm9tPMf52pN6GyHwK8IM8NUW3gn7jw+zCzy8ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8nnlwcg45cELYQg1AkE1nuAlnjwUYRLua/GLzqxObfkjsHxbM
	pRXCmJhqxxCKKp58ihrRJXiatG0zOuyHDfrcjOfGPlKQ5ypyaZKmAyTO0cGMHzdgZVzejijmuOA
	WWmVNR6S2F9i93wV9VeTwUZ0/jGlKq+k=
X-Gm-Gg: AfdE7cnwnbTr13j9XeHPiDvIrwsvUCfjTUYHRmgoBrxz4POeHUOJxVrG+zHkbtdy+BB
	qhdABU55TnGYGp8JX2DSJlt5IGXoivb9Nk5fDlV580ytUKlMRc3CRWvb5J8ECEI3r46K5CF3b9h
	ApyMXsuPlnzEfN/m/5D/scn9UJ3UCGtmXwxp0goALI0mZZmoiXVzNC95IaHgNCXkHY84+CtPbDK
	ftJD+dLnOZoV5JyVR+fnlDpTJtoNqiXxCISmG1PFjA0OGRd5NGWSbn2Ge+v4W5aMTqzDtD4Hbs2
	mU7ctAW7rcbNQIKQnHsW/0EbbU/N
X-Received: by 2002:a05:7300:fd07:b0:2e2:4979:ec7 with SMTP id
 5a478bee46e88-30c0cff3be3mr746177eec.10.1781854363507; Fri, 19 Jun 2026
 00:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617081622.32823-1-harshal24.chavan@gmail.com> <2d35e4d2-72ec-4ae8-90ba-8c9b1e53c58f@kernel.dk>
In-Reply-To: <2d35e4d2-72ec-4ae8-90ba-8c9b1e53c58f@kernel.dk>
From: Harshal Chavan <harshal24.chavan@gmail.com>
Date: Fri, 19 Jun 2026 13:02:31 +0530
X-Gm-Features: AVVi8CczKaIUl_9UotqYyKsDvtGpmGAExPbjHfpqkLzDrVO4kowikfq6u5cB3ys
Message-ID: <CADCAkb60QQriHJ_eZoOXpo0cNCCM5n1Lwr_tCSs2j1=gXCiqgw@mail.gmail.com>
Subject: Re: [PATCH v2] [PATCH v2] io_uring/register: add IORING_REGISTER_CLONE_FILES
 opcode
To: Jens Axboe <axboe@kernel.dk>
Cc: krisman@kernel.org, kees@kernel.org, gustavoars@kernel.org, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 6/17/26 14:54, Jens Axboe wrote:
> Not sure the offsets and partial copies are going to be worth it, but
> I'm willing to have my mind changed. But that's a minor thing really.
>
> Also a question whether the destination should've already allocated a
> sparse table. This kind of bundles the two into one. In general, as
> mention on the GH link, I do think this should work exactly like cloning
> buffers. It'd be somewhat confusing if they don't match up, as it's
> essentially the same operation, just on a different node type.


> > +    /* Copy original dst nodes from before the cloned range */
> > +    for (i = 0; i < min(arg->dst_off, ctx->file_table.data.nr); i++) {
> > +        struct io_rsrc_node *node = ctx->file_table.data.nodes[i];
> > +
> > +        if (node) {
> > +            new_file_table.data.nodes[i] = node;
> > +            node->refs++;
> > +            io_file_bitmap_set(&new_file_table, i);
> > +        }
> > +    }
>
> This definitely won't work - I also mentioned in the GH link that nodes
> cannot be shared, you have to allocate new nodes on the destination
> side.

> The file nodes rely on non-atomic refs when being used, which is
> protected by the ctx->uring_lock as that's always held for the fast path
> issue. If you just assign the node by reference, now you have two
> different rings manipulating the same node in memory, but they don't
> agree on synchronization.

Thanks for the detailed explanation.
In v3, I have rewritten the cloning loops to utilize a new
helper function. It strictly calls io_rsrc_node_alloc(), get_file(),
and io_fixed_file_set() for every single transferred node. We no longer
share references across rings; the destination ring is fully populated
with its own newly allocated, private nodes to avoid any non-atomic
reference races.
