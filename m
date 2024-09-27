Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02819ABD4;
	Fri, 27 Sep 2024 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444478; cv=none; b=W1LFO0KzMEf6T5d/xhsj3eSXpsQ6qV5gOq88nRSlDqaKtayYJEXftkoElB5qPs97hy/D8O+0oc65wCIDOCFGXK6CT7DbcEHbyBO4KzVj8BsH/jHLa8St7o0UiMuEciA6hgZC6zzdrMtPzJu8/8UWVub168AbviB4FOlwuyesvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444478; c=relaxed/simple;
	bh=gI6HCMfYo206j1dF/5CqQAMvd9oA/DGlIIqu3b41Yos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ec0WsHbbRPdQpkXlMbw0Wvqpu6tfJo3V59cD1wge2LVA2BJ3Q+KEQ40/qYXXYwbqBynrS/y3JTy2HhldaiAEWXGjU/MV5i3+BSZvMSgXj0AtIbcDWzQriwJekA5S52anEHQmlWAd/d6FUboT4PDwcBtgPy2xu0QigPBwvXgGHyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oizr7bw8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oizr7bw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEC8C4CEC4;
	Fri, 27 Sep 2024 13:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727444478;
	bh=gI6HCMfYo206j1dF/5CqQAMvd9oA/DGlIIqu3b41Yos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oizr7bw8C023CNIijNEfxbcwsbjUfgO4j6eKmgW1/LZRUqQDepkin/cxM8byxF5yg
	 aJkp/GxicAgWn7KP7JxzxJ4fMhxeq9Pc74RqTHs1MY+DiEqF4bHIRvxqTAsheXhaR4
	 6WSiLPWiyaFBIBJx5Fgg/wzqxwBzpfmkOLwvXvVUU9ar5Ql8FsY5loy+cPkxg0Uk7g
	 Uvu33nyIjbfkSF9s8efqeOEgu1VoWefuSbNgOW5tQ+7tkwnnAEVCyb2usrE++X/BJr
	 BKJCwhPNUjCfBX1fzhnGHfwW3vzfGQHg1d3NjNo/IxolggjeHC/Mtb3hCGJg+J42+u
	 0h3IUT+2EBS/Q==
Date: Fri, 27 Sep 2024 06:41:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [djiang:cxl/fwctl 13/25] drivers/cxl/cxlmem.h:798:44: error:
 'counted_by' argument must be a simple declaration reference
Message-ID: <20240927134116.GA3695247@thelio-3990X>
References: <202409270908.NJPL38kw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409270908.NJPL38kw-lkp@intel.com>

On Fri, Sep 27, 2024 at 09:39:54AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git cxl/fwctl
> head:   b4f2900f53c72de8fc639b62e44763c6a9695d3b
> commit: 5a0496c19151d83cd0d926f8a1488eeaab27509b [13/25] cxl: Add Get Supported Features command for kernel usage
> config: arm-randconfig-004-20240927 (https://download.01.org/0day-ci/archive/20240927/202409270908.NJPL38kw-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240927/202409270908.NJPL38kw-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409270908.NJPL38kw-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/cxl/port.c:7:
>    In file included from drivers/cxl/cxlmem.h:6:
>    In file included from include/linux/pci.h:1646:
>    In file included from include/linux/dmapool.h:14:
>    In file included from include/linux/scatterlist.h:8:
>    In file included from include/linux/mm.h:2232:
>    include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
>    In file included from drivers/cxl/port.c:7:
> >> drivers/cxl/cxlmem.h:798:44: error: 'counted_by' argument must be a simple declaration reference
>      798 |         struct cxl_feat_entry ents[] __counted_by(le32_to_cpu(supported_feats));
>          |                                      ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It seems like this should likely use the __counted_by_le() macro so that
it is only used for tracking on little endian targets?

>    include/linux/byteorder/generic.h:89:21: note: expanded from macro 'le32_to_cpu'
>       89 | #define le32_to_cpu __le32_to_cpu
>          |                     ^
>    include/uapi/linux/byteorder/little_endian.h:35:26: note: expanded from macro '__le32_to_cpu'
>       35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>          |                          ^
>    include/linux/compiler_attributes.h:105:62: note: expanded from macro '__counted_by'
>      105 | # define __counted_by(member)           __attribute__((__counted_by__(member)))
>          |                                                                       ^~~~~~
>    1 warning and 1 error generated.
> 
> 
> vim +/counted_by +798 drivers/cxl/cxlmem.h
> 
>    793	
>    794	struct cxl_mbox_get_sup_feats_out {
>    795		__le16 num_entries;
>    796		__le16 supported_feats;
>    797		u8 reserved[4];
>  > 798		struct cxl_feat_entry ents[] __counted_by(le32_to_cpu(supported_feats));
>    799	} __packed;
>    800	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
