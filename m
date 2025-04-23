Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B329B234;
	Wed, 23 Apr 2025 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422497; cv=none; b=EEcWGppGprQ3zyYPw8P7TT1lu/6Q6vFdeX0pviGT6XLz5hzbvOpQz543V9WMbChWAPO5G1cvSgotf2Q5y04Cz5t+TPNNDzSX+JrDKuGAmf/CpxAOx+erY6ejeBxItLTr4x28qy7zBRilZhycUZrgJ4WE1do3b7iMWJq09cIekSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422497; c=relaxed/simple;
	bh=Xxenez25Q38AH9fsXJGnqUA44hSEjkp2u9luWlh8gCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUOF2GCBFndTw+G7rFndkEoYGfEz4IDchGpHMwz0vu1dHrqLrfFuQG4x7UQ3omjWn6qYZjGPq8QT5KQvxab8u46/6h7jE2GpjTqquPSaS8tYD0X8dgnl/2Avkd6MrksLUCfP4JQpnzyQKm+Ij8JjDIbNUKBsGkalntI7+RIS9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMxcTmAy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMxcTmAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4A3C4CEE2;
	Wed, 23 Apr 2025 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745422497;
	bh=Xxenez25Q38AH9fsXJGnqUA44hSEjkp2u9luWlh8gCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMxcTmAyMctfMrtLTBBXDWVuqAU0odGiZOrObJt8nFs1ULqyHX6EOW9XJ8gAv2Al+
	 ls9TW+darJzWgqXw72VXP8YFPVo11b5nb4wdSyx0Vex4KlKugMgUq5V8RrofN226//
	 ayl8j6+jxM2heyBoG/PGk+5f8OrZp+icLG1b+Kf4fE4l5+A5pF11BY+MeUzLgGVVCy
	 76qzKXdf6RWw1+AmLmbCxSXZ8VN2jdWqaayORF7ejuZeO+Sd5zId/QUXUdZcWzPhoG
	 WoFcn6Ormbu+ol2ABSt6P+u0xGkM8tdLC4KC1OcpHXsSv0qciQfx8oAMYL3hjzjiwQ
	 ZoHpE50wR/0og==
Date: Wed, 23 Apr 2025 17:34:53 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/nouveau: disp: Use __member_size() helper
Message-ID: <aAkIne5RbZMoxxJV@pollux>
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

Applied to drm-misc-next, thanks!
