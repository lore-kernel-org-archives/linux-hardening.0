Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DDD245AF6;
	Thu, 13 Feb 2025 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483471; cv=none; b=nu7ePKU0rCOrpCDWI6Hk0w7Ld/AmMFGv5WZqVs0FpLb1uTn9LBTN+9SN9VoG8s5W6atUNNWA6F/nSYnwOoHuY6NqCZiIsHPFH7AaJOHXngIuZSfBD4p8/vH5bDh46V579cR1KZTtxDd4W4oM4ZXvb1XD9d64rVTAUlH2sqW0IJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483471; c=relaxed/simple;
	bh=QIHU0vuozW1jHEuDARsKseSufbCGWG5lAbafy9b9Ehw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGs2rbFqcGjlJdeU/F3GvYZoZwLc+xKz31kNKVJRvYwGw2kYJSwwOJvHDlbY7Tp4wlAuRfRG/gvltSlevrZRcgBqz5KRADlybtwz5iLJoqOn5fPBmkhJBePwzRVo5O6I1/um/0mFY1UnA5eSVGQqOki1LEBIZHvCwRR/vsUUDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJxTNJUu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJxTNJUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33549C4CED1;
	Thu, 13 Feb 2025 21:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739483470;
	bh=QIHU0vuozW1jHEuDARsKseSufbCGWG5lAbafy9b9Ehw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJxTNJUuLUsEGXVt602mWe40FzJLbCVKHHoQ7HW3mHGzkhUT8FuyRCQTIqdXl62hw
	 VeNXMbR4A3EtmyYj7cVQzf7hIjl6eTZm+Po8mEOjNWBzwBfb3CqONuLwvBQx1UGWl/
	 +ed2BYcb25zOH6BzTgsLKRAcNrg3NVlU8ZaTaDPsxXKVgirDXOgvnfxU/RxXrCb8Dk
	 uxyWp0dbPnHmtzt+M/mXcBfQMzTG8c8ZmPH//w+H4Qz24yopd9D9xHxxD71EduKgfg
	 4GFGOqVFbLO0LyT2TxarA9WmsstsHDO2f084J+X6IehaWceDPrwfcmRBYi2BEC4JG8
	 PD6kOFIK7RDXQ==
Date: Thu, 13 Feb 2025 13:51:08 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs
 with __counted_by()
Message-ID: <Z65pTO03U4qq7N9g@bombadil.infradead.org>
References: <20250114214956.915982-2-thorsten.blum@linux.dev>
 <CBE23F82-A597-4DC5-A297-26F8DEFA07B0@linux.dev>
 <EF59E5FB-5998-4BD8-9E51-6B52198638CA@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EF59E5FB-5998-4BD8-9E51-6B52198638CA@linux.dev>

On Tue, Feb 11, 2025 at 02:18:08PM +0100, Thorsten Blum wrote:
> On 4. Feb 2025, at 17:44, Thorsten Blum wrote:
> > On 14. Jan 2025, at 22:49, Thorsten Blum wrote:
> >> Add the __counted_by compiler attribute to the flexible array member
> >> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> >> CONFIG_FORTIFY_SOURCE.
> >> 
> >> Increment num before adding a new param_attribute to the attrs array and
> >> adjust the array index accordingly. Increment num immediately after the
> >> first reallocation such that the reallocation for the NULL terminator
> >> only needs to add 1 (instead of 2) to mk->mp->num.
> >> 
> >> Use struct_size() instead of manually calculating the size for the
> >> reallocation.
> >> 
> >> Use krealloc_array() for the additional NULL terminator.
> > 
> > Hi, could someone please take another look at this?
> > 
> > It was already applied to modules-next in August 2024, but dropped
> > shortly after because of a Clang issue:
> > 
> > https://lore.kernel.org/all/20241029140036.577804-1-kernel@jfarr.cc
> > 
> > The Clang issue has been fixed for a while and this patch could be
> > applied again.
> 
> Hi Luis,
> 
> you already applied this to modules-next in September of last year [1].
> Could you apply it again now that the Clang issue has been fixed?

Please resend and Cc new co-maintainers, we are rotating every 6 months
so to helps scale and support Rust modules too.


  Luis
> 
> Thanks,
> Thorsten
> 
> [1] https://lore.kernel.org/linux-kernel/ZuHaiiMV6ESS8p7z@bombadil.infradead.org/
