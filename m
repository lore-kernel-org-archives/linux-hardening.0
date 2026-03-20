Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58F1A6822;
	Fri, 20 Mar 2026 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773965792; cv=none; b=EYw4x3ekvHOk/FS6hbUW3t7qO8HOB6ZTk4VsMS9tWSZiCEvt/69gehZWfvML+45dP6vVqje/lRuUK25g4uLY5lhGDl+5wwmAHfWWlibhvgAONxIBBlsntUYvX2sMjM5IfJVtiFe8AKrSQQC+mg3E8ZxkXKd+5Z2mBpZaECqigEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773965792; c=relaxed/simple;
	bh=q0QTKfatk8SajnZ7rG3ZXbS6BU3a/d+gGNwBkEvkzkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwg3v7ivo77CU5dlKlVgje2XtD06vMvtp8Au9m8t/gjQRFiPwiCqFvGCr8O1/yC1ElEONHgCa9bnScmFnBgstDLPwC15uHkUARty9HfkDsb8YVfvykLuktsdWw7LILYvN2yukJFzMrPlPYIJYTcNfVx0dQrO52arGxk9ElbU7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OITthvAC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OITthvAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A07C19424;
	Fri, 20 Mar 2026 00:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773965792;
	bh=q0QTKfatk8SajnZ7rG3ZXbS6BU3a/d+gGNwBkEvkzkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OITthvACZ/ySpjXesS+3DuUVPGcVV4R5xscIhfNopvEBZzpc752zuS+ZT+cj9pbf8
	 jKEQHC+R1MQIDjGyS9syaEJR7Ky0A1YkRRwy7kcIVpxFPoGVY405RL0tUwEy5xWECI
	 +1Ovn5ClQTyu2EFOYBrFbxAK3i3pwjivU56deEP7mEkC8DusqFLefI76ya0HzycqeQ
	 ajTBTk3zNWSnN3CALM51ToB1hA54ZkVuz8Zw3hqL33Tpm/fwWUnjHOaA64Xq2qycoc
	 IPUj2yhwBTr2aUwGo3kl3TJijyafRC2uR0OXsbfaSa0dHhtO7bXzzsKhHiXEKEIjAv
	 Onsf++wRhxzaA==
Date: Thu, 19 Mar 2026 17:16:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Elad Nachman <enachman@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org (open list), linux-hardening@vger.kernel.org
 (open list:KERNEL HARDENING (not covered by other
 areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: Re: [PATCH] net: marvell: prestera: use kzalloc_flex
Message-ID: <20260319171631.65836fe2@kernel.org>
In-Reply-To: <20260318192111.6802-1-rosenp@gmail.com>
References: <20260318192111.6802-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 12:21:11 -0700 Rosen Penev wrote:
> Simplify allocation by using a flexible array member in this struct. No
> need to free separately.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment to right after allocation as required by __counted_by.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: reject
