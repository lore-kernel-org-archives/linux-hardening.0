Return-Path: <owner-linux-mm@kvack.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from kanga.kvack.org (kanga.kvack.org [205.233.56.17])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07782C4332F
	for <linux-mm@archiver.kernel.org>; Sun, 18 Dec 2022 12:22:12 +0000 (UTC)
Received: by kanga.kvack.org (Postfix)
	id 61B298E0002; Sun, 18 Dec 2022 07:22:12 -0500 (EST)
Received: by kanga.kvack.org (Postfix, from userid 40)
	id 5CA5B8E0001; Sun, 18 Dec 2022 07:22:12 -0500 (EST)
X-Delivered-To: int-list-linux-mm@kvack.org
Received: by kanga.kvack.org (Postfix, from userid 63042)
	id 491738E0002; Sun, 18 Dec 2022 07:22:12 -0500 (EST)
X-Delivered-To: linux-mm@kvack.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by kanga.kvack.org (Postfix) with ESMTP id 363258E0001
	for <linux-mm@kvack.org>; Sun, 18 Dec 2022 07:22:12 -0500 (EST)
Received: from smtpin28.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 11B2412014B
	for <linux-mm@kvack.org>; Sun, 18 Dec 2022 12:22:12 +0000 (UTC)
X-FDA: 80255339304.28.36F35B9
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	by imf29.hostedemail.com (Postfix) with ESMTP id 4B6F4120006
	for <linux-mm@kvack.org>; Sun, 18 Dec 2022 12:22:08 +0000 (UTC)
Authentication-Results: imf29.hostedemail.com;
	dkim=none;
	dmarc=none;
	spf=pass (imf29.hostedemail.com: domain of gouhao@uniontech.com designates 54.92.39.34 as permitted sender) smtp.mailfrom=gouhao@uniontech.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=hostedemail.com;
	s=arc-20220608; t=1671366130;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id;
	bh=VpeNMVMeCUejPTy6Ey9jPU/H1sPBBKr46ptDY4XIGgc=;
	b=HaKbS4xAOT+Znf/2UBZleSDp60jTvLETixLOlxbtRrchEU+f0kfBRfQksigrUOgwltUNSd
	7fWe5StlXHoyHtWtgYjxCn5fxeBsF1iXAuM4HjXS1cFXKVNlhS5ZQmv2pXWDagnOUN0hMA
	sU/ZHu2QmBEVRu7eZrIOLHS/c9XkI2Q=
ARC-Authentication-Results: i=1;
	imf29.hostedemail.com;
	dkim=none;
	dmarc=none;
	spf=pass (imf29.hostedemail.com: domain of gouhao@uniontech.com designates 54.92.39.34 as permitted sender) smtp.mailfrom=gouhao@uniontech.com
ARC-Seal: i=1; s=arc-20220608; d=hostedemail.com; t=1671366130; a=rsa-sha256;
	cv=none;
	b=sdbrkRvf/uNjIdreHwB3r1JIuPrtDqbhAcZ1ID96Yqa5aSnszox9jKpwhHC9mAUQZRjT5T
	Ev9HS/l9rpB9eB7ruVuGMkzDUiulQ0Su+NzecQ3+r9K/6DALM+Ig1nTDYJnTYg8RhRjjxy
	k40YoTyX7C/JumNfnwG5TsYg/HpRxgI=
X-QQ-mid: bizesmtp73t1671366088tbvk7of7
Received: from localhost.localdomain ( [113.200.76.118])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 18 Dec 2022 20:21:26 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000B00A0000000
X-QQ-FEAT: znfcQSa1hKaSjZnQWBOwkBxrihDOW3MYPJd3J1ZQ/EBhgaF5qMZvfDVJm+bVS
	SzRqrJfpZ3FKm/SnWinMQMdr+maXmAGewmcIQNMny29y7nlmzLaegW8VD2qdSgQG8gL3F5h
	YPr/ESZuPMc5uIxjJFyLkkq3iZXkulY0Be/lk7Cgqxe1Q4VEsRqz9qI4zALfzyPD4zGY/DA
	27a+obEAsSxUAJheOiDDK7DGk4Y/8KxPIHPp9xun7drnqCc9ZCY3VnCq9WnO0oV439knSk2
	4Sl+1JxMfmSKEDmuVgcKDKv08vtoaW9nWuCx+1zr0QzxFwxnTvKTrY0t+dQ71234K9wseHw
	t7ZZIq5M0lyg5n4Ek8GMe2DYSXCzqVA15vb0ouYpkIIYBWj0mIf0J8Xr/NOedD6PC+l6sYJ
	U2BlnQ3OJpG6ymfhtGGmIw==
X-QQ-GoodBg: 2
From: gouhao@uniontech.com
To: 42.hyeyoo@gmail.com
Cc: akpm@linux-foundation.org,
	cl@linux.com,
	gouhao@uniontech.com,
	gouhaojake@163.com,
	iamjoonsoo.kim@lge.com,
	keescook@chromium.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mingo@elte.hu,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	vbabka@suse.cz
Subject: Re: [PATCH] mm/slab: remove unused slab_early_init
Date: Sun, 18 Dec 2022 20:21:24 +0800
Message-ID: <Y551tFBVcYxPlFlH@hyeyoo>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221217113045.15997-1-gouhao@uniontech.com>
References: <20221217113045.15997-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Rspam-User: 
X-Rspamd-Server: rspam04
X-Rspamd-Queue-Id: 4B6F4120006
X-Stat-Signature: ptc1jge4g5jz9qc1wdzodrkaap5ufs75
X-HE-Bulk: true
X-HE-Tag: 1671366128-644949
X-HE-Meta: U2FsdGVkX19hI/MHfkpNoFyLXBMJOZhnKBhIS8ghJ7YdOfQHAVaT0h+nrg0KYOuz21ZhpUiaCb9gVOZuXPFY99ONmwaO1saTnhB8ThmNUtvBFVH4akbxORznYVwjI8Yg9O0eQy73WOTxX88wC69oHnksXU+ZH4oibVVkLXmp4bkbvntnrDYQ6QYuvz+4Ym4shDdchfNllDDue9fKJZ8BRm4giM4gaRER33WayXjwJQs6U4F0MAmf9CloTXMMxO2shmS1wjlMkBPlpyFD9S+3TrfW/TPQQFBAORC5af4VqBuGlUYj/2/o5YYq7ZIelq6lUHgygbahEmL0AOFKp3xKBkIfuU3+ZB1cmrZ+zPV2Yz2/8mOE/eMyc9vu/6ianlssUo4pT46Wv9L6ETr3UX3t48FMXHJtReIU5NB60FsySaJs0pLQ+TSYOBvYbnhP1nLQmYjbfK6lYmSI4OS/4D2nhE6u2YLPN/LM029r869x5v+ZYhVqotLnh9drEXhVoMxEg8qiXBkcJKqI3xlZoE9g5bVXM0NQBFSw3UD/9tHmxYVnrE/EB5CvkAdOCdzx+Qv/tHhvvhZyVGGa3PUL4tHvi7oTvJI2EjaQCaJrQl3RoWYBldfGs8u6hRbiBWVgacBr2lFFt4VUCQ1YJKbAVqASjH2Q0Ugbyrwk9LzXhSIsntvPCAO7TS/geJK/QCPWKM8Wkpua2wdcHIJY9AbtWzG7x5Qz/rizBIh2ttqHsi+zlyiYplgpKxTtF609ZojjpyhJFurGy8pT93ZXro6HNvlGj0Lt79b9zzeVcQBFF9Nez/QejlQx7SHQX98efAr+K/abHHuHPtat8et+C6pyAc7T7t9HuQqP+DwcyJ0pMcDQyPIBZh3A8psJ365XW0AMI/LAK3Ut/p7zJy/toUebG7KuDetuo+qPjNTG9CBVmBy4druZljDoRu1XZEVak5dOTzGr/29duRXCcm3rheAXrWM
 rvtr+FIR
 lUlWNsDhXsRjDw4R6BeQ1JseqgYmCxinLZiDCGuZy6Lsop+HJ7ZokrRpPkYCM12WtnQ+s
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.4
Sender: owner-linux-mm@kvack.org
Precedence: bulk
X-Loop: owner-majordomo@kvack.org
List-ID: <linux-mm.kvack.org>
Message-ID: <20221218122124.Kuun5apb91BTz_KynMWo9kaCOqCUYzOkI6qWEyYnsWQ@z>

> On Sat, Dec 17, 2022 at 07:30:45PM +0800, gouhao@uniontech.com wrote:
> > From: Gou Hao <gouhao@uniontech.com>
> > 
> > 'slab_early_init' was introduced by 'commit e0a42726794f
> > ("[PATCH] mm/slab.c: fix early init assumption")', this
> > flag was used to prevented off-slab caches being created
> 
> s/prevented/prevent

Thanks for your review, i will fix it in next version patch. :)

Thanks,
Gou Hao
> 
> > so early during bootup.
> > 
> > The only user of 'slab_early_init' was removed in commit
> > '3217fd9bdf00 ("mm/slab: make criteria for off slab
> > determination robust and simple")'.
> > 
> > Signed-off-by: Gou Hao <gouhao@uniontech.com>
> > ---
> >  mm/slab.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/mm/slab.c b/mm/slab.c
> > index 7a269db050ee..ede1f29fd81c 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -220,7 +220,6 @@ static inline void fixup_objfreelist_debug(struct kmem_cache *cachep,
> >  static inline void fixup_slab_list(struct kmem_cache *cachep,
> >  				struct kmem_cache_node *n, struct slab *slab,
> >  				void **list);
> > -static int slab_early_init = 1;
> >  
> >  #define INDEX_NODE kmalloc_index(sizeof(struct kmem_cache_node))
> >  
> > @@ -1249,8 +1248,6 @@ void __init kmem_cache_init(void)
> >  	slab_state = PARTIAL_NODE;
> >  	setup_kmalloc_cache_index_table();
> >  
> > -	slab_early_init = 0;
> > -
> >  	/* 5) Replace the bootstrap kmem_cache_node */
> >  	{
> >  		int nid;
> > -- 
> > 2.20.1
> 
> Nice cleanup, thanks!
> 
> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> -- 
> Thanks,
> Hyeonggon
> 

