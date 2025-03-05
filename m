Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679925BADD;
	Wed,  5 Mar 2025 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214567; cv=none; b=C4+AWh2NE/y+GmAH/qFEtXmuvHXaovwXI7vZsT/I7mwWDOQN2GkZMoVWoJoZKuymfV2EG8dpFtZfn1Tbmurvzumom7ZTincXMMnS9mOrEJAPbaW9G27UDmmOlQz4o7a49BxN3DQl590eJxPZ29fj7pRaJqGnpxbPtbwbHMddi/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214567; c=relaxed/simple;
	bh=VubAq8JQlhjmpzCkbcA9d1tTOjIITfOjNdC2xk7Y3UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJhqQMP0VhblHkpWB5Qc8m4iH/pY1roV58D35IkOSmjRlTss+TNeGIfn67pjS25NdyM2Y06jqbrQPAh+K6Ja2pO83NOAl/WBXRhDljopUpJPbGSFKdfA1QPMpk9sAVqPsu0f3ytmrQ2udQ0roQpx+wPNo//42LQ9ITClBWPYG94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQg0mX8l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQg0mX8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A96C4CED1;
	Wed,  5 Mar 2025 22:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741214566;
	bh=VubAq8JQlhjmpzCkbcA9d1tTOjIITfOjNdC2xk7Y3UA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQg0mX8lQ7QBwQJ3doTU4iXHoUZ+RwEjKpGoGhCyIWThF7zcXlWb3jZtzsatnDuJH
	 MgOrNsXlSKqnjqI+biKUoNsDXwM3SC0q8u9WlIjAzJiTQikDmM1aSy8qqpV6BK+F0+
	 55AUNw4NZEy4U5imo5n84Wbjo8a6+0a3cp+vPuWMkV4Mbwp2SSRyhNxW+MKnWkAkDX
	 Msx96AJ3bMup2hrtx7eoLNFtYEgqFdKv72kMQkVcH8aQQmK8HkFvGOdVlSkYVkw6MS
	 ZapDOjGygHbhHgd14RL1kytj+y8QAFCCuQ+tO5gZzOUYuJl/6WbJXZGMNQoA1bSviK
	 UANEKox8PwHKw==
Date: Wed, 5 Mar 2025 14:42:42 -0800
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Bill Wendling <morbo@google.com>, Peter Rosin <peda@axentia.se>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [RESEND PATCH] mux: Convert mux_control_ops to a flex array
 member in mux_chip
Message-ID: <202503051438.01AD65C@keescook>
References: <20250302230220.245739-3-thorsten.blum@linux.dev>
 <202503031040.223DEF2781@keescook>
 <20A47316-D274-45DD-BA15-F66139654D44@linux.dev>
 <202503041935.AE2093CFFA@keescook>
 <20C5E493-4FB3-4347-844B-1AFE6B9FCDA4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20C5E493-4FB3-4347-844B-1AFE6B9FCDA4@oracle.com>

On Wed, Mar 05, 2025 at 05:31:57PM +0000, Qing Zhao wrote:
> This does look like a bug in the compiler, could you please file a bug against GCC on this?

Okay, thanks for taking a looking!

GCC: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=119132
Clang: https://github.com/llvm/llvm-project/issues/129951

-Kees

-- 
Kees Cook
