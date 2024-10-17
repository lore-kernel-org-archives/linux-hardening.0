Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F921DF99A
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183702; cv=none; b=TKSlIRHtGA0zURG95XOLrJ6L2c9ePtaoPJ1R+XoUEwJAyAIuShojPKpcukjb3lj5CUiRZVsk4Nx6R+uzX/yywjeknwR4lECzmXWAHBLSBVPsEEvZKl/36ucfAIg5tKak8EnJNSa/eOLaxJWXY66kMp3qFcPUkFAreNAidqwRIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183702; c=relaxed/simple;
	bh=yxJDk9QkFqZdpDHfn0ZNgHE+njf6ZVSVPt+THyz9fzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5N6t6r7vbDQKqoszwEHWQWcZjOyTb4zUa3B3p5+fiaN7Vf/cir/tGcdp0hUZzr5l5iNQPXD7vE9gYWjnegUiOQmxf1hOaRRD8xam57sCw++RuYtrllk6DYIWKOuX6HQfGOv5yidOZiXbL8mSjH1OlbJgVZvm4PshhNJ8TSbuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kcsa8mQc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kcsa8mQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB6AC4CEC3;
	Thu, 17 Oct 2024 16:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183701;
	bh=yxJDk9QkFqZdpDHfn0ZNgHE+njf6ZVSVPt+THyz9fzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kcsa8mQc+2d0oa+ZurE/65xZmsay4JoOmmXqHhiX8kYF4qKBwJNUDo60phalbuc4D
	 /aawfL1o+/+btGj+B2RNh356ghQJNHEtvCuYrbBwjze4OizBSnNMYzNvTEjILUoE66
	 Kpy4l09vpiZpOMkISgQD0HCjdRdZ7hEC2bTM5d9HIgRREX80jxndEIVoQ4cfc4Bqzv
	 6B+Gvcx5rhsoRc8yPvlbsNuqdKoxoVssA5cGenKddJGcN8dSh05ProkRBfGAiZM6jM
	 zFb2BPPvDEWK/rmr2QMxCtX82/6LcESCvseG74Baj/gQFwetOGYOsxE7OO1ThphlmU
	 VIJrO83qJSkXw==
Date: Thu, 17 Oct 2024 09:48:18 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: Fwd: [linux-next:master 4380/4439]
 include/linux/fortify-string.h:293:17: error: call to '__write_overflow'
 declared with attribute error: detected write beyond size of object (1st
 parameter)
Message-ID: <202410170946.C3D7594@keescook>
References: <202410171420.1V00ICVG-lkp@intel.com>
 <CAHC9VhQasYp3dkv5Mx4uEy7ZmtYWywU2wJrto_xvUAjgScXL5w@mail.gmail.com>
 <202410170847.F6C111256F@keescook>
 <202410170922.0B55ABC@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410170922.0B55ABC@keescook>

On Thu, Oct 17, 2024 at 09:23:25AM -0700, Kees Cook wrote:
> On Thu, Oct 17, 2024 at 09:07:13AM -0700, Kees Cook wrote:
> > Something in the .config is causing the error. (!?) I will start a
> > CONFIG bisect...
> 
> Well, I did a code bisect first, and it reported this which makes _no_
> sense:
> 8afd8c8faa24 ("lsm: remove lsm_prop scaffolding")
> 
> O_o

Looks like a GCC inlining bug. If I query the size of the destination
buffer before calling strscpy the warning magically vanishes. :|

Lovely. I will see if I can construct a work-around.

-- 
Kees Cook
