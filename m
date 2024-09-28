Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A22CA8;
	Sat, 28 Sep 2024 21:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727559587; cv=none; b=TbVEYYMV9EEVBjKw9Oo8h5O1d9oRnXC8kND8FFhR5jG0FrKlpoPl2F+lkjTP5KycyN06VzDa2WZ3H68v7VLPz1S0lsNF1Bc0RIcZceDNMk8w3UeptI6Z83mKTRk7Rk6diodfDTXVi8kmy8rSdLoktE+BS4ES3WHQ8uoA3NpI5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727559587; c=relaxed/simple;
	bh=eLbNYpkjv4mF+Vkacdfkj5LjcqdJCwZ93LZ8X0O+69I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmYppMKkR1Ba4khAL5gJoHqAHQvAaxe89iRdeDMQotr+348vpEJUHso+DsyavUrXUIwQucdMssWSKLvI0NzLfYf5A8udJbC8RfOMC6+O9xgzQl0arsj3ev+hwloia5YYDOlR02PBfDwiPuHag4uHv1nzNlhfiDwPgEMic9JfVuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qwf1PCIt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qwf1PCIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768F2C4CEC3;
	Sat, 28 Sep 2024 21:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727559586;
	bh=eLbNYpkjv4mF+Vkacdfkj5LjcqdJCwZ93LZ8X0O+69I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qwf1PCItM+4hoN4NIkVFYeXGrUdnQN+7GqEK7Lv12hmvMnrt5hFIiNG3AnBv0VYPu
	 NNITGtbkAMo2mnEM/D0kkqPFV2WCq3dG0l5zu9AamV9h2xwzbx+DS18+OEiq2AY95F
	 scXULwwWR2LtPtfZieB+o0Mnvg8qJPRBDJW2vWaR7nJO2jA7ZgUczZrP/FomXvB24d
	 5IQhUQQGyoBerWa9aToh1+o9YiWtgPXZSPeFdHs7Ajh2+zoYj40fMYMz/VS+8qkM8B
	 39gI+fFJTogyb+m36AeQ8Q3W44H+PYqn7bLe55jdej22GZleIwadxY4uf/nESwFFvF
	 GhMBcADwDiVDQ==
Date: Sat, 28 Sep 2024 14:39:45 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vegard Nossum <vegard.nossum@oracle.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Allen Pais <apais@linux.microsoft.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Vijay Nag <nagvijay@microsoft.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] coredump: Do not lock during 'comm' reporting
Message-ID: <202409281438.EAC4B88C@keescook>
References: <20240928210830.work.307-kees@kernel.org>
 <20240928143532.39559729f9eceee468358abe@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928143532.39559729f9eceee468358abe@linux-foundation.org>

On Sat, Sep 28, 2024 at 02:35:32PM -0700, Andrew Morton wrote:
> On Sat, 28 Sep 2024 14:08:31 -0700 Kees Cook <kees@kernel.org> wrote:
> 
> > The 'comm' member will always be NUL terminated,
> 
> Why is this?  I thought this is only true if the caller holds task_lock()?

Because it's always written with strscpy_pad(). The final byte will
always be NUL. (And this has been true for a very long time.)

-- 
Kees Cook
