Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2985F7DA66;
	Tue, 22 Apr 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336974; cv=none; b=J9OL6qNXMFsxuXx5hxXDyZcfM3x6S2rz5dd0Z6uzN6mzAwUs30kiV7AWITIfHG4z79F4alvreUH/qzFxAaWsfdrkICipIU1EM+b5BZyFK6ykjSgAC7Ky/j3x2Ow9ET5CtHJWy6YuuhYeF/Z7DinhjfaVtMAlPzrc7rjctdpVRmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336974; c=relaxed/simple;
	bh=5GOMuvIE+7EsbF04NswrnSuLp3VvDN4BQnu1VTgx080=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTL99uygds3UD4Niw8I28CiSLXyJdz1fpVkBjZ30dBXXT/0SY7RHCa/bC6ZWQOkCQFekHirMEuH6SMFLGmhgjq7vtcQyJVl2u0NRd28oYCZgn6MwkFM25JaW2E8jJLVhdz2E5/CyPLy3F/vxj7u+So7yWkAYwNPoogHU9nDGSHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2ik30OE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2ik30OE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DE8C4CEE9;
	Tue, 22 Apr 2025 15:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745336974;
	bh=5GOMuvIE+7EsbF04NswrnSuLp3VvDN4BQnu1VTgx080=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s2ik30OE2PgSyHjVZ3CA+slsyUMRhiQ9+E9aOz1/kSCVSB6csdlcpr9mBOgYB0hZb
	 yVwFq9w6HexungrrST9nr19K+OfpXVQnWgzJWwEOs6rtjuxEacLWrRtus8JwTt5uUv
	 Iyyuxue2n5aSttEbaXPhHlwVtPludc/m+AZTpU/efh8sWyJUY7XQnxLYMBbDu4Nk2v
	 d+QYLUP/5q3bJ1oG37m5HUnQMMZ95LDmKuMYheRTgeQCOXf7L7NebwoHHFARngqYCs
	 Oswv0/YpKwtrq6AXlBklXOew6xhfKnaKSvW54yLjrlI/cgAVdJmBvDVbnZBZldYS8N
	 Cv5VCkGSxjOMg==
Date: Tue, 22 Apr 2025 08:49:30 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/nouveau: outp: Use __member_size() helper
Message-ID: <202504220849.3BDE692@keescook>
References: <aAe5o_-f5OYSTXjZ@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAe5o_-f5OYSTXjZ@kspp>

On Tue, Apr 22, 2025 at 09:45:39AM -0600, Gustavo A. R. Silva wrote:
> Use __member_size() to get the size of the flex-array member at compile
> time, instead of the convoluted expression `__struct_size(p) - sizeof(*p)`
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
