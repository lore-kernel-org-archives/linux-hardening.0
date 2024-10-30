Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726C1E573B;
	Wed, 30 Oct 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305524; cv=none; b=arcphDg0oiSybmNjLeB7J2LzeHWEHOjYHPLjI1rBCGgwyGPhuOPWtBjRFOoEo8fwVKiRx0ZFrtgZ1Rd8Sg3SAQDZ+YaE0Gy11vqNCSFck5afLrraMdqWNenjV3pJ+VsgGioNVHQLcQUGz9+tZ2ABtDocMFkL/yuBanBqxhpHQog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305524; c=relaxed/simple;
	bh=QWIeTXul61kcR00izmmjwcnmv/TndCE/YkT1ZlRXlWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0RDiFp6pwxQGm+O1j9Tm2f3wNwo9mjKZgLHMxNLdp86cXs6EBbYE9InbiXNL8034dQv8Or9AgGZ065ZjO6uxvN0AAE5LC5+E4ECnc7BVRF1R2XjPZjWEOOjLUU11Q7Clio9guiTnSTu8PRBUy1Fb+uGw4mF4LCaozdUzwt7G6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpNxpQKM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpNxpQKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A690EC4CECE;
	Wed, 30 Oct 2024 16:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730305524;
	bh=QWIeTXul61kcR00izmmjwcnmv/TndCE/YkT1ZlRXlWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpNxpQKMij5LZffVRkSLrfSVrnrcR3bj2W59qrFetZzwxsHbymOVJCLohgihZeCIA
	 4nHfOXx3J9V226TqA+vMyTfJY+MwQehQKuMZ6kOp21faKmeOJ0A0WX0O4ReNTd7wvQ
	 Qpl37I1ssFcjgShWzN3hIWs8wPcGwogVXReIgHe52N7hma66YnvkYM72Uyi2XLEEFv
	 qTraDY+oWPDZ7C3O8+K4fe9/p+l2zs9c6S1e/XfZmHuj0auXbtv8ag3L+PgIWpZf5l
	 pT5AaELmfkPXf0OoYqZpVay3Mb5PkExM3tE+sa+3I1tEYplBUjf8IPlAiG1JOzxYRl
	 BaWvP3NKprUag==
Date: Wed, 30 Oct 2024 09:25:22 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ira Weiny <ira.weiny@intel.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, kees@kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [weiny2:dcd-v4-2024-10-29 9/28] drivers/cxl/cxlmem.h:755:35:
 error: use of undeclared identifier 'regions_retunred'
Message-ID: <20241030162522.GA2228266@thelio-3990X>
References: <202410302001.MMV7mxpl-lkp@intel.com>
 <672247c28d533_3ab9829427@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <672247c28d533_3ab9829427@iweiny-mobl.notmuch>

On Wed, Oct 30, 2024 at 09:50:42AM -0500, Ira Weiny wrote:
> [snip]
> 
> > >> drivers/cxl/cxlmem.h:755:35: error: use of undeclared identifier 'regions_retunred'
> >      755 |         } __packed region[] __counted_by(regions_retunred);
> >          |                                          ^
> >    16 warnings and 1 error generated.
> > 
> > 
> > vim +/regions_retunred +755 drivers/cxl/cxlmem.h
> > 
> >    740	
> >    741	/* See CXL 3.1 Table 8-164 get dynamic capacity config Output Payload */
> >    742	struct cxl_mbox_get_dc_config_out {
> >    743		u8 avail_region_count;
> >    744		u8 regions_returned;
> >    745		u8 rsvd[6];
> >    746		/* See CXL 3.1 Table 8-165 */
> >    747		struct cxl_dc_region_config {
> >    748			__le64 region_base;
> >    749			__le64 region_decode_length;
> >    750			__le64 region_length;
> >    751			__le64 region_block_size;
> >    752			__le32 region_dsmad_handle;
> >    753			u8 flags;
> >    754			u8 rsvd[3];
> >  > 755		} __packed region[] __counted_by(regions_retunred);
> 
> I'm not sure why my config/compiler did not catch this typo.  I'm looking
> into it.

You are likely not using a compiler that supports __counted_by, which is
currently clang 18 (although soon to be 19.1.3 [1]) and GCC 15 (tip of
tree), in which case, the macro just evaluates to nothing, so there is
no validation of the value to the macro. It would be nice if there could
be but nothing immediately comes to mind because of where this macro is
being placed.

[1]: https://lore.kernel.org/20241029140036.577804-2-kernel@jfarr.cc/

Cheers,
Nathan
