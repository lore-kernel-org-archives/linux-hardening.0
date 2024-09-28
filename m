Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D12CA8;
	Sat, 28 Sep 2024 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727559998; cv=none; b=LqmYAjfk7eUHIcmFsDYPtjFUNP5rV8/lZyyDfghv9EtcasW3y2JQzkwQQ0vRZw8H0L28eUAYvKRec2FG8YFNfFSPV1PnB7Ilz21fkK7/B7dUDzfXacyVcz58yFyzzipXStuDrsRYdVoituXNz8wbjwefxv9LokK4zqc43cBXX4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727559998; c=relaxed/simple;
	bh=wgShOUBwNyOLdVG5OC1hti2GQUdY7KxkaSb3nDpX0GI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Q3sQW1VrSYg5Su7vB9nhDeL45VKD/f0ppf/zH6Fwffp4F3WEHPoYmVbJwttHaXMgIud5POgxy+wQkM6/NxEv2+C47PzHDMTBfMJy5ChlTMpbVPUfSysFCHozjDGseE03DzI3lo236JGleDlPKjfHEeIoPcwDthxqawDw6DINpqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G3XgCTkj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G3XgCTkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555FAC4CEC3;
	Sat, 28 Sep 2024 21:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727559997;
	bh=wgShOUBwNyOLdVG5OC1hti2GQUdY7KxkaSb3nDpX0GI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G3XgCTkjXImU/FMcRNeyS4VjtgJ4vv7554NqYc/y4THlTdW1CXPi5ToPlEWiuQTv0
	 XMD/GlyShIsf/XTgBfTcvvArLN2ou0d1PA9Z6N76XxlX5QFSxZGFPVxrRGXLckqp0R
	 vQrSz5tw0Ul7KGrLIU1wrpOZjNpAZSYcZiPeagzg=
Date: Sat, 28 Sep 2024 14:46:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Allen Pais <apais@linux.microsoft.com>, Roman
 Kisel <romank@linux.microsoft.com>, Xiaoming Ni <nixiaoming@huawei.com>,
 Vijay Nag <nagvijay@microsoft.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] coredump: Do not lock during 'comm' reporting
Message-Id: <20240928144636.d1964e6c6bb77c3e9123fc64@linux-foundation.org>
In-Reply-To: <202409281438.EAC4B88C@keescook>
References: <20240928210830.work.307-kees@kernel.org>
	<20240928143532.39559729f9eceee468358abe@linux-foundation.org>
	<202409281438.EAC4B88C@keescook>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Sep 2024 14:39:45 -0700 Kees Cook <kees@kernel.org> wrote:

> On Sat, Sep 28, 2024 at 02:35:32PM -0700, Andrew Morton wrote:
> > On Sat, 28 Sep 2024 14:08:31 -0700 Kees Cook <kees@kernel.org> wrote:
> > 
> > > The 'comm' member will always be NUL terminated,
> > 
> > Why is this?  I thought this is only true if the caller holds task_lock()?
> 
> Because it's always written with strscpy_pad(). The final byte will
> always be NUL. (And this has been true for a very long time.)

So why does __get_task_comm() need to take task_lock()?
