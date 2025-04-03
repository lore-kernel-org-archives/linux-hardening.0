Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877F72475C8;
	Thu,  3 Apr 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696326; cv=none; b=ieBlWC3OqHVnvmBcldw/s0EoYXKvo5vWMdxnBR8EOVAoNFEgfEBKSJikho812ov684WOyCC6NUAoz6Y7g/iQHUhWX9bM6VKm6C+Yb8dXl7G4gNgfA6hv4lvrFd7i7/b3PagTN+RbC2RCdbN7yE3Kfn5W9mCrS5oH3JSz5aifz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696326; c=relaxed/simple;
	bh=5oFcHW6fLd29eIcRqoPsjzMZUmyrM09yRwvZ8iioyDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0OWrzM5fTtKHyeRXx20qGqzRDVczUIuHcYJMionTYEYD6V2VRVQCWZqsOGyqXq/jO20+pqNN02F3jkQdT3N9zghVbD0ILjKtPXsWkXKowJLtlaCaTibrQpaueLAq6LEbH4tKjb5RBMPHiSJYiCHLX13BTuhBdDTZ1pbGbCZpJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skrtmWUi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skrtmWUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D61BC4CEE3;
	Thu,  3 Apr 2025 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743696326;
	bh=5oFcHW6fLd29eIcRqoPsjzMZUmyrM09yRwvZ8iioyDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skrtmWUihNf/PqlZuGanZNZp+U/xAbelfEDrx5yFHpDigUt/ASIliJMxTyfbzOlNb
	 d6Hu2wGkLaRsNdJKSDYsbB9GECdTqPnwdWExUIez2hGEc85NpgCRmPUhzDqsUWR3Q3
	 BciXmPjcBh1rZKm/FZSBPnRTiU/+MdKIfOfq+HWO/cXTqt/bvLJ44zLVrIs8uwdzjh
	 mJzR8o+joVhWP7tm8dAfmN1yjIr5elAsFle7KT0xu17MDl6i/us3yHqy+haRgIefym
	 BDK735N9AvySC7wI8Yn1sRmqeUDUm9XfUmVfeAYlaw0ZQHjPtekaXTv5Qc+/ccraq0
	 kQ8pyER1N87hA==
Date: Thu, 3 Apr 2025 18:05:21 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] drm/nouveau: disp: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z-6xwS3qXIyxE05G@pollux>
References: <Z-2zI55Qf88jTfNK@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-2zI55Qf88jTfNK@kspp>

On Wed, Apr 02, 2025 at 03:58:59PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> 
> drivers/gpu/drm/nouveau/dispnv50/disp.c:779:47: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied this one (as well as the svm and fence one) to drm-misc-next, thanks!
