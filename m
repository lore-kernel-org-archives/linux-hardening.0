Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B318D643;
	Mon,  3 Mar 2025 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027679; cv=none; b=MDANCXZTIkR0S6SGkiaQKq8vLX9dw69T9vjKYflxJ/JmtluJzDM0P3bKN1YFTV0jKbZxOwHljFj55oDw8CgGccNThvE50191VLX5H9YYn80get3+34Ab6py0Zk91doWttsYTmjwzaqGNJg8d3vQSo/twwQVunWhzr05CoAQ4KTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027679; c=relaxed/simple;
	bh=5oWRROZqGFHuAlhA/NK9lyi0GVa5LcWNwWWm2UXCBq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLiIUuccNig2SJXMaQFDGDIFQmQ2xEB/AUfAdgFmjg5B/hnTDdCB6PF9xyLjk0Scgr07+8MdtfphszGJjPIt7ORURcj+8wfHlbuT5Qsd4Kz4i2iUYJBuLHrxG07b/M9yfKf5BfjMnWtQxdhgk4/+hRxo0CnBWxKR90zSXgborEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S97TeUIc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S97TeUIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA237C4CED6;
	Mon,  3 Mar 2025 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741027679;
	bh=5oWRROZqGFHuAlhA/NK9lyi0GVa5LcWNwWWm2UXCBq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S97TeUIcJ8hwHDjxj8fX2DZzbpz/OFG/6qUrnIOhgE8d3DpEZOattu+XViC3jiwdj
	 sUEJZig/GdL6quDxN/QJpPn9WRIbzpQ4zIGOy+aD3P6OwCeS1OzZxbpoBBZZkdaRNT
	 GwBtz695kfJjufCJLAzUdPyASyLRSQ9ThXAY92kDyAJHNyIiMrqc8+E48cwa5bDKsp
	 rUSbKvL4NlB81s2gGhwm54LRWClRIl0QW58sot0qWbIDjiTkk1oYIqWNNp1XOjbMGq
	 pBvxaqxzU7rb3RwplSbkFV9MJ30y6+/9G8er3F+51tS3tI9ge7p+Ln5nQjvCw0gxzF
	 4BfgvdEzyaFbw==
Date: Mon, 3 Mar 2025 10:47:56 -0800
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/gma500: Replace deprecated strncpy() with strscpy()
Message-ID: <202503031047.E80BD9D83@keescook>
References: <20250225203932.334123-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225203932.334123-1-thorsten.blum@linux.dev>

On Tue, Feb 25, 2025 at 09:39:32PM +0100, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers. Use
> strscpy() instead and remove the manual NUL-termination.
> 
> Compile-tested only.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Yup, the adapter var is already zeroed out, so even if NUL padding is
needed, it is already present.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
