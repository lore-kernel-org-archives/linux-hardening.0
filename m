Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243428935C;
	Wed, 23 Apr 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422477; cv=none; b=h353TbkCiyuNJxyeIZDbJiiM7iVhDwwp41cKzh8hL1kO5NeE6Zjcs5m3/pY8EzF5nrrXhMKISibR/y3XsGntXZeJi48ui0dARPXCf3G+T354GAPgWQktLu4dveXg2w56jXQ69ATgsaDJDg8bsG7T1X8YQe/jsaGeEKc/5upBLZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422477; c=relaxed/simple;
	bh=exBE5kRoxBHfsybraWEptUQZRKthYMhF21X5DHd+Qgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TghcTh6lRIaUmw6P+VBYlxxVdQIi/yvP92odYp9YV2klq8afQ2pGQHn577cOQkMwpUleOL/KJHJbTWCNEvpLxg2rngLFQnOeI/P7EjegQum7HNNF1AtV9h0god6G89yg10gnpVXqQFc8sQ4BTdllymifBTLQXl/66M12xfYDIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIGVB5dw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIGVB5dw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ED6C4CEE3;
	Wed, 23 Apr 2025 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745422476;
	bh=exBE5kRoxBHfsybraWEptUQZRKthYMhF21X5DHd+Qgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIGVB5dwShH891883K5hglERVmByjaFPOGlNwPVgISFyG6CrDZgvs9bnOzTi10utH
	 Qgq+x14iXC4A9i81GODsbkrDvNdVhIyMXTp6Q3Pwm24VyHILBMt/OQZ7QrrJvq+hp1
	 UCtQubl8CR+PWWvZdXHTwEVckXKSXJLFvvrTxZfSfwL8n58CeN8cTZVpIWaKsi45xy
	 sK4pg5HyhKf8lMzTNOXC+uv+k81blW5tFqTzLilseyNoUjxOU1mncUeeIofAwqAcUf
	 hK6jtQBZv6VTl83D/SAStD0/6k7bfwv+SsS9soUCRAgRWf5oFmHDYlcghMUT7rtnJw
	 zaVE5yKhbEhlg==
Date: Wed, 23 Apr 2025 17:34:32 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2][next] drm/nouveau: chan: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <aAkIiKbPaYEYUtv_@pollux>
References: <Z__wSgHK5_lHw8x9@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z__wSgHK5_lHw8x9@kspp>

On Wed, Apr 16, 2025 at 12:00:42PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for a few on-stack definitions
> of a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/gpu/drm/nouveau/nouveau_chan.c:274:37: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/gpu/drm/nouveau/nouveau_chan.c:371:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/gpu/drm/nouveau/nouveau_chan.c:524:42: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to drm-misc-next, thanks!
