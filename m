Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726BC213E89;
	Tue, 30 Jun 2026 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832523; cv=none; b=k/r9jsntEaFxZtyGK7H/WIBt4Y1sBsEHKFCZXIlTq43exR8oLy6d8VFO/YyKDXxTiCjxxIF8mDbCa+dtyyHqtjpg+RAIHBFOkJXW8i6+vAOAz1AEkUDHjylaDQ1lqZmstzKeK1HQy5s7t3ta5YzJzakt8Ixnj+idDyLmEpWFD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832523; c=relaxed/simple;
	bh=f1c4FlMC3olZxC3giH+6deLBbehRifubsyfC7HTpIQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnFiJSRdLbXu+HczoiTcstUvHgHlsZz+oKU1EHn3ZZuELBrEN8PJU47AbvB33kVITkvS3njE5IG83spqYCSKTLsY7M4WTYguG3yLNuNkWs14H09SRj0dgXydeFqSB40Qpg2YjM+FYV5irnmdjP1NWZy4cQACicVb8Yvtbl45w0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xy4sZ/o4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xy4sZ/o4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782832521; x=1814368521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f1c4FlMC3olZxC3giH+6deLBbehRifubsyfC7HTpIQs=;
  b=Xy4sZ/o4TIOZiYODVW80ip/lu4tBzqed2d+Nrq0v6ZZSZXTR/mY1qXGO
   7WcLlbynN6BQDKldx49qYFfyQ6m1ouFFjSP6xawKKZGH20S8BIYsEHN9o
   wfhL18+h0YqZzwOFz4d0t4hlT8v1zrRoiDrEpYXCnuL4sYo1XcgiJ8DFg
   q7ng8SD05nRmgg7O1/qdnCnO7suSMKAs6/zXhQ9eWxb1v3jOPOyxlJazY
   mBLbFH5OsPLVOLrtoR1yPTgjVErzS5voVqiEVwxmavhsCyju5pSPVEnBh
   uhyy/OLTm31e4vPbbDfhsBISXK4JQsS6h0T5vN/rToi58ZYsNrPByYl40
   w==;
X-CSE-ConnectionGUID: cDW0gXZfSj+/7rukDm1MZw==
X-CSE-MsgGUID: IdGD1TxBT8iKwADXZthOLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="87386286"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="87386286"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 08:15:20 -0700
X-CSE-ConnectionGUID: lstz0gkFSimhaXBdx8wchQ==
X-CSE-MsgGUID: NMO51T81Tk+iW/xUz5199g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="247820700"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.240]) ([10.125.109.240])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 08:15:18 -0700
Message-ID: <bddb2695-1b64-469d-be6d-e668fae18d84@intel.com>
Date: Tue, 30 Jun 2026 08:15:18 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Pedro Falcato <pfalcato@suse.de>, Xiang Mei <xmei5@asu.edu>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-hardening@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>,
 Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>,
 Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>,
 Yan Shoshitaishvili <yans@asu.edu>
References: <20260629214712.1198680-1-xmei5@asu.edu>
 <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <CAPpSM+QTiwgPk3KNmWbjSk_SS8LLL5XDfikWC1A98vetom3yeg@mail.gmail.com>
 <akPT82jDvPwlaNuo@pedro-suse.lan>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <akPT82jDvPwlaNuo@pedro-suse.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 07:40, Pedro Falcato wrote:
>>> To even be considered, this series needs to be refactored properly.
>>> Making this VMAP_GUARD_PAGES a separate patch is the bare minimum.
>>>
>> Good suggestion, I will do it in v3:
>>
>>     1/3 - introduce VMAP_GUARD_PAGES
>>     2/3 - mark percpu vmap areas VM_NO_GUARD
> I would suggest you create a VMAP_STACK flag and condition these guard regions
> bsaed on that. Otherwise it's a bit arbitrary as to what callers get 0x11 guard
> pages, and which don't.
> 
> (you can find the concrete stack allocation functions in kernel/fork.c)

The real question here is whether VMAP_STACK is a good idea or whether
__get_vm_area_node() should grow functionality to manipulate guard gaps
and then just have the stack allocation code use it directly.

I, personally, despise code like this:

static inline size_t get_vm_area_size(const struct vm_struct *area)
{
        if (!(area->flags & VM_NO_GUARD))
                /* return actual size without guard page */
                return area->size - PAGE_SIZE;
        else
                return area->size;

}

I'd *much* rather it be something more like:

static inline size_t get_vm_area_size(const struct vm_struct *area)
{
	return area->size - area->gap;
}

for example.

Looking at every use of VM_NO_GUARD, I think the kernel just gets
simpler if it goes away. It's only referenced in 6 sites:

 1. __get_vm_area_node() - Munge gap argument into 'area'
 2. get_vm_area_size() can be replaced as I showed above
 3. kasan_mem_notifier() - just pass a gap=0 to __get_vm_area_node()
 4. kasan_alloc_module_shadow() - just pass a gap=0
 5. check_sparse_vm_area() - check area->gap instead
 6. Just remove VM_NO_GUARD checks. No flag means no munging the flag.

