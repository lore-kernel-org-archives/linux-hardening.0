Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA90224B1F;
	Wed, 16 Apr 2025 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831799; cv=none; b=ULOt2UhpQHoeHVQZQ3/16TmgByrDVP9kMTCjn0lkF+6W6KGQdG1Np/m2LLDNeAoIyEfzFY1AY8OPOVq1lJgTa+WrDi4vwj8ydMp/BbC+Jntggh5hGEzwFO3pNzzfu+Kj2qwehx3+YCt00MBlybeM31lgZzyYG8k2rF2hN/JmJgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831799; c=relaxed/simple;
	bh=qF7kj3F5ENfaPg1irXDHt0Snb+hZQJsb7ZoIgWnqEqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbxbsbItP7MC1+XVxd+86giJgVG24qvse5o67LUlsorv6HAaijpmCsEJHjkOIT0J4GhusBS0HZIxD4ujg+wvP98AyyQcdUg1g0va7ESQ1RGMFnt1+iLVFFksNyJT1DK8KMoWChwwm0JERQTkifwXNyjfZuY17d+8SV/bqfwXZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/liROoB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/liROoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C32BC4CEEC;
	Wed, 16 Apr 2025 19:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744831799;
	bh=qF7kj3F5ENfaPg1irXDHt0Snb+hZQJsb7ZoIgWnqEqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/liROoBKK5q0LiBefrgs9vuCJenfP/K+UKHR4wodh90iq05s/dmq2SfrEw2iVx1E
	 KJtN4dB8tdI2mv7Cz9mm2uoqpIRipfbb21FcGD7/1gVHgpBdSyqbhgA+o9NxTttLM/
	 3dURnByRhPmDxVBsTkvK9VbsbBRYJ6RCtYoYW2lJrTQgrGYAOcwBJGJZRXtIxlic9o
	 9cWQVvhByC+pI+bsghjFDziZ2fBiYnGqURReD6thg534nTiS30szNEk73EOn12RItg
	 wcMjirn9VHwwrgnzG40nNQHwFJ/Vrt7PRDUSW3Gmwe5qKdu+MSs+1esU5TMmi5tK/9
	 1t+VBWvM1V90w==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: Clarify expectations for getting DEFINE_FLEX variable sizes
Date: Wed, 16 Apr 2025 12:29:47 -0700
Message-Id: <174483177863.740549.2239617505557790214.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416172911.work.854-kees@kernel.org>
References: <20250416172911.work.854-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 16 Apr 2025 10:29:15 -0700, Kees Cook wrote:
> Mention the use of __member_size() for DEFINE_FLEX variables as a hint
> for getting at the compile-time size of the resulting flexible array
> member.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] overflow: Clarify expectations for getting DEFINE_FLEX variable sizes
      https://git.kernel.org/kees/c/2122b4571745

Take care,

-- 
Kees Cook

