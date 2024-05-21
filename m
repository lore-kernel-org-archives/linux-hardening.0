Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5F81F959
	for <linux-hardening@vger.kernel.org>; Tue, 21 May 2024 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261649; cv=none; b=OtmjXLifkbPQDPfZxrxRP9Bcvj3tHpfIQlVUpdBdrsbcZaPiH/eclBfCfuDBZ5yvYBOSXMHzXl7/tukwB4zfnforS1m0wdrBvMUNy6c7+qG4HgWqLu/WTMLAfPK5xLGINXZ1o680Tz8XqbYChUUZQMFbf6rlRa/yJRDIfB4ebRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261649; c=relaxed/simple;
	bh=oSid7q9yF/QER5pI2kle11hKPiIovv9NqtlhlMTkHdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPD2VRGJePnV3EF0d42N+fX8G2i66CmTweb+M0QDiyFKXUb+hkxGcrmGNOntaEJA+6ShwkFAMU/lSWga1LkLEh/IMYoUugfn2GgcYR0bWYGOHTkCycjlaEd4ZAhzk90xEvx+1i1hgC476XEUxDee6vEjydF+wn+a94O/f9z3Wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBkKs+US; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBkKs+US"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716261647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYQBu6zkfNaoqqNc//ysbuuuADju5TmrSNilJ4cHGKE=;
	b=UBkKs+USMkX+NpcEYrm/aDN7ElqbII6EPvElVPWTmJcMtWi1fX/S9s5d/SBravWzsFMeEZ
	HHuJdisyLy/vOPYHyMXiSPWaVJNK6Ic8bGFLULVpA40PVLUqk2Tyw4wdqziFLBBPXewC6q
	zh+xkWZq2z7CkoxHXz3OzbkYjQpL2Js=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-maRvBiRFMj-o6900q3ZQgg-1; Mon,
 20 May 2024 23:20:43 -0400
X-MC-Unique: maRvBiRFMj-o6900q3ZQgg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D3D31C05137;
	Tue, 21 May 2024 03:20:43 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1435B7412;
	Tue, 21 May 2024 03:20:41 +0000 (UTC)
Date: Tue, 21 May 2024 11:20:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kernel test robot <lkp@intel.com>, kexec@lists.infradead.org,
	oe-kbuild-all@lists.linux.dev, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"(open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_byb)" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
Message-ID: <ZkwSEUEW/RKFLubx@MiWiFi-R3L-srv>
References: <20240425100434.198925-3-coxu@redhat.com>
 <202404262003.qsWvGwZU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404262003.qsWvGwZU-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 04/26/24 at 09:10pm, kernel test robot wrote:
> Hi Coiby,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.9-rc5 next-20240426]
> [cannot apply to tip/x86/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240425-180836
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20240425100434.198925-3-coxu%40redhat.com
> patch subject: [PATCH v3 2/7] crash_dump: make dm crypt keys persist for the kdump kernel
> config: x86_64-randconfig-r113-20240426 (https://download.01.org/0day-ci/archive/20240426/202404262003.qsWvGwZU-lkp@intel.com/config)
> compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240426/202404262003.qsWvGwZU-lkp@intel.com/reproduce)


Please respond to the lkp report in time whether it's a problem or not,
otherwise the link will be unavailable.

> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404262003.qsWvGwZU-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> kernel/crash_dump_dm_crypt.c:31:3: sparse: sparse: symbol 'keys_header' was not declared. Should it be static?
> 
> vim +/keys_header +31 kernel/crash_dump_dm_crypt.c
> 
>     27	
>     28	struct keys_header {
>     29		unsigned int key_count;
>     30		struct dm_crypt_key keys[] __counted_by(key_count);
>   > 31	} *keys_header;
>     32	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

