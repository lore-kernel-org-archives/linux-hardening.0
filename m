Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CAD39AF9
	for <linux-hardening@vger.kernel.org>; Thu, 23 May 2024 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716442523; cv=none; b=WNKwp61edcZNeF7FTpbWhlo+8+9pq1r28IF5eSWxY8Uzi1f9dFRdz1PtX3YpYHbWJ2E1LEs6I4yQiYAZdoFe1VtL8e+dQrgfLYY0iqp5GPVKEk6UANrVfLuIsS54ntHvkojSVMeBuehT1yrglLwVjNvn5G3lzto7+fHcqH5/1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716442523; c=relaxed/simple;
	bh=9MSePypnN2x7tkFIRXGJk1Lfzb+uoHj4i2u0JdsvilY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EXXFFHEs5etZhpQVBEhnTD4/f9vLV9SR/j2+H/PSK/rMX4SmSOE1spqj/c+083A69wAOG2W7JJYOVteVD7lktFEmVq10ZMKOEC0qkllEWRik7OezoYpb4CHp8y+Cp0qCuBGlz1QIAf3TI7Yjw49N49kagcGmFWCA0xkibdDaLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZb6tY+7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZb6tY+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716442520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkVYYwuuRqZJhdNUMtbXmkO5vXRSiVRryfoV8WYL+q0=;
	b=ZZb6tY+7e9en80uM08iYl6kjXi6ZDzsUKAq5xLvd1mCG3fXm9XoSRlrAdZNdlRi9jj0gRe
	Ya5Leq1Fw3um8gmDIZY+ElrrP3qO/GyA1V4tQhNdCgyGCKbBdjhK4QTjohuKaBBKD3TSAI
	uSBeJXx6g1kxDJEKJ2nT1lrEYIZDmCg=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-iT4_OYXZNYWmo08Fg7VXdQ-1; Thu, 23 May 2024 01:35:18 -0400
X-MC-Unique: iT4_OYXZNYWmo08Fg7VXdQ-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6f0ff570f62so1095295a34.0
        for <linux-hardening@vger.kernel.org>; Wed, 22 May 2024 22:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716442518; x=1717047318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkVYYwuuRqZJhdNUMtbXmkO5vXRSiVRryfoV8WYL+q0=;
        b=wur1EUXQaGqzPpdnKjW+eILDqSySGdBuAvLS/Lt0Gukz0yB/M0y4C8y1+x3k9FvY/K
         dS1+e8Z6+YPpx3siizwod4Egeqmx1RVNniBR/dCF/iV6IjuV9iiDvhGINsfhUHf9i7fy
         wkcUVnnvxWuATLHKgvG/fsPE3QkGCIaUpP54gWx07fneAD5DqTfyQsamnKJOTrjke3WH
         Cg/FXmMBX/MvtTu3UtSwN8Qbz9odIV1y3Ji0m1aM1Y2fDrLeR6BW3YkyAgroZdFBuNmg
         aebaPQRI5gscOZ5ptle6s3SO3sG62OtPlCNtSF1qrRIRQQU5H4eA8bcg4kmJv5LwNt1S
         GibQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKQ2zeFCF6hkW4ZcydlKf5qLQtMmFa0+xyv5QLEH6sOf5Eb73LPyjXReDjyJKH2q6PdxXpThT5SONsyJ7yoTFpfQy+cWiCkXnx+iZN+/55
X-Gm-Message-State: AOJu0Yw+2+HetCR1jcsONVcn49PfmFkBHeA0m+IQ6WG+p+z8kWH35w6H
	7DFvvKlzDl3YyrANkw+It7YtUQyLSQkWL651WjdB8e1N9WReAHhgTXbTYTpaJ0KiSJDtvjDIzAz
	bbNA7WnRfo8uyG+4Pyhg6O8YffL+sFgZTs7GxNJAJGqWdQOtFNgviEKq672WaR3q8hw==
X-Received: by 2002:a05:6808:1cf:b0:3c9:924c:8304 with SMTP id 5614622812f47-3cdabd20d70mr3851747b6e.0.1716442517756;
        Wed, 22 May 2024 22:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU9TCM4OePsLNJcyJGxLImpn1NPmzuyatA+WiPDO4CMkcIyNbE/3eCPkgw29C+PBMkQ6fM4w==
X-Received: by 2002:a05:6808:1cf:b0:3c9:924c:8304 with SMTP id 5614622812f47-3cdabd20d70mr3851705b6e.0.1716442516284;
        Wed, 22 May 2024 22:35:16 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2d767sm23300983b3a.186.2024.05.22.22.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 22:35:15 -0700 (PDT)
Date: Thu, 23 May 2024 13:34:23 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>, kernel test robot <lkp@intel.com>
Cc: kexec@lists.infradead.org, oe-kbuild-all@lists.linux.dev, 
	Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Jan Pazdziora <jpazdziora@redhat.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"(open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb)" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <xnsvk5wlfuxomr3aayz6essyzgofux5orj366cizh5525ygbbx@tpdunjmf53m7>
References: <20240425100434.198925-3-coxu@redhat.com>
 <202404262003.qsWvGwZU-lkp@intel.com>
 <ZkwSEUEW/RKFLubx@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZkwSEUEW/RKFLubx@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, May 21, 2024 at 11:20:35AM +0800, Baoquan He wrote:
>On 04/26/24 at 09:10pm, kernel test robot wrote:
>> Hi Coiby,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on linus/master]
>> [also build test WARNING on v6.9-rc5 next-20240426]
>> [cannot apply to tip/x86/core]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240425-180836
>> base:   linus/master
>> patch link:    https://lore.kernel.org/r/20240425100434.198925-3-coxu%40redhat.com
>> patch subject: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the kdump kernel
>> config: x86_64-randconfig-r113-20240426 (https://download.01.org/0day-ci/archive/20240426/202404262003.qsWvGwZU-lkp@intel.com/config)
>> compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240426/202404262003.qsWvGwZU-lkp@intel.com/reproduce)
>
>
>Please respond to the lkp report in time whether it's a problem or not,
>otherwise the link will be unavailable.

Thanks for the reminder! I've fixed the reported problem in v4.

>
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202404262003.qsWvGwZU-lkp@intel.com/
>>
>> sparse warnings: (new ones prefixed by >>)
>> >> kernel/crash_dump_dm_crypt.c:31:3: sparse: sparse: symbol 'keys_header' was not declared. Should it be static?

Yes, symbol 'keys_header' should be static! Thanks for the report!

>>
>> vim +/keys_header +31 kernel/crash_dump_dm_crypt.c
>>
>>     27	
>>     28	struct keys_header {
>>     29		unsigned int key_count;
>>     30		struct dm_crypt_key keys[] __counted_by(key_count);
>>   > 31	} *keys_header;
>>     32	
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
>>
>

-- 
Best regards,
Coiby

