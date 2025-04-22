Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1042E28FFC0;
	Tue, 22 Apr 2025 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336966; cv=none; b=sT8A/aiTsg5UjZeyT4/Qbr8oDeqEel4C/E5DleX7BfhobbhWluJoa3gV8CzCYxwCKZ/G23jaGsxrYcpgxZ6jGWjwL57d+qWmdWsJA+qpeaMG7tNrGUngbLPYgf2MD/AckORUCKr5/0mXknXqazMAfD/O0sGgsODU4Dsu2nMbtNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336966; c=relaxed/simple;
	bh=F8r3LMqn4Bi/IWC6gn/fsQt778NPJ8n3QrgvX+Iq9C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqVBeZKeSlaSP7XEgIDw3c5WtdtPKgQ1kKFaQHE1KTUz0ueVmpIWTLgyHS+JCJ4+J1T00iwmC02M8EqDA+RT8GmlKMkbDv4OEG2eZElNqnXQZP/+KGJ+LSqvIJac/pGph43T65qHR257+gF9wCxHjFwjZQAkeZM5LqAQ12IUjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgvmWMH+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgvmWMH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EA3C4CEE9;
	Tue, 22 Apr 2025 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745336965;
	bh=F8r3LMqn4Bi/IWC6gn/fsQt778NPJ8n3QrgvX+Iq9C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgvmWMH+IDP1nMUfhkQDwf7RRMKP0kemox5om1901k7NzTYJ3JBXH3EpnFSFRG3d9
	 x8+cLHcG1hJxPPSS9o/jrePHanM18OqeKp1fvc8O5cNGjn9HsmEkyZ//1IVe2dg1bd
	 /kwNRDq+np5LP1U9NR/EWkNJtpfiMtxwfWxUoOv/gS+B29sxFcW3PWbmeTciiuSxr4
	 DXlVnx/18NDQadYi5A+Qt7TaDvLyNRPNpQo3toqGG9p7uQCa/I6H+tv7RDNu2U0+sl
	 dVwF/892EzGUuZkAG5hALymoMku2+CvTSYmVVEtBYS5GMTZxlhxQOSWHMmzTq5TwO+
	 GrmLtL5uVYsLQ==
Date: Tue, 22 Apr 2025 08:49:23 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/nouveau: disp: Use __member_size() helper
Message-ID: <202504220849.A8A9B1D31@keescook>
References: <aAe5eNDnRyGnxLMX@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAe5eNDnRyGnxLMX@kspp>

On Tue, Apr 22, 2025 at 09:44:56AM -0600, Gustavo A. R. Silva wrote:
> Use __member_size() to get the size of the flex-array member at compile
> time, instead of the convoluted expression `__struct_size(p) - sizeof(*p)`
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
