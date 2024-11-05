Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1417A1E8856;
	Tue,  5 Nov 2024 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832821; cv=none; b=ZUN9f+jgY+xnXiSAzUZ01TP/LH6nd1k5U6vVIGsGZPsiyNv83oBDlw5/2VkApiHfOxeWiOTjXzzTcxshgbOpC9lyM08d7aYYDhd9cLHln/TZ1Af2BTXgnEtu7xY+AAovDl79n0HxlHKqK/72XlxNTOU9ncVBWdomCSMc5iiqCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832821; c=relaxed/simple;
	bh=om6rkjCoic/HMRV9luPqYYqcRUsZZcFyJ5uPx4VR+so=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JG0xneMfy5LxfZJ3TYoTvMwfsb3dmvrDnp8hiXRcPxQF3NopmkPuTlOA+sn+8NIYONaiv9+XqkcHWvW6J8ZHFdKYLptVmeP/VT0rkDjmzcWKIJSleGzaJALUhQOPwKh51qP2m3VTxE1jnvKsmjm9TzYRr5TORa9LJOmx6KVM38I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=x8/kr3Sf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="x8/kr3Sf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7270DC4CECF;
	Tue,  5 Nov 2024 18:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730832820;
	bh=om6rkjCoic/HMRV9luPqYYqcRUsZZcFyJ5uPx4VR+so=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=x8/kr3Sf3zgtkRPo9BXCr385XtsqtVInUO3JETepMbYPTEU8cqvL6/r3U6t+Pc3D8
	 mqFmUTx7CQecFYxXpsanjkpRFThsF3cQYYWq0keYZUuvjHfSUbKcerui75+rQbkHvw
	 g6GGQv/sCACRKwlYab9VLCrn85R23Xgt/qaEY8dw=
Date: Tue, 5 Nov 2024 10:53:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Christian
 Brauner <brauner@kernel.org>
Subject: Re: [PATCH] freevxfs: Replace one-element array with flexible array
 member
Message-Id: <20241105105339.8d53c034b0d3fdd66139cdec@linux-foundation.org>
In-Reply-To: <ZyoAGsCAdWrGMQoj@infradead.org>
References: <20241103121707.102838-3-thorsten.blum@linux.dev>
	<ZyoAGsCAdWrGMQoj@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Nov 2024 03:23:06 -0800 Christoph Hellwig <hch@infradead.org> wrote:

> On Sun, Nov 03, 2024 at 01:17:09PM +0100, Thorsten Blum wrote:
> > Replace the deprecated one-element array with a modern flexible array
> > member in the struct vxfs_dirblk.
> > 
> > Link: https://github.com/KSPP/linux/issues/79
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Might be worth adding that nothing does a sizeof of the type or
> variables of the type, so just hcanging it is fine.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Andrew, can you pick this up through -mm as there is no freevxfs tree?

I assume Christian can scoop this up?
