Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62159307487;
	Tue, 30 Sep 2025 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248401; cv=none; b=kVF4vRwby0dqA6hooVALAXneaOkRruIKQfjfg8/t3FkuthZr3hnVEDMN+tohacB/+w3pZFTGXrdK2wP/gwxMmWoTdDk7PbiQW4rNtlF/fPYuXpYsPHfTlB1lX0niXHcrNS5+1UKMuxL/jsPb5cp5Hs1COA+mtBtrbq8elHyUw3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248401; c=relaxed/simple;
	bh=3VW6ohul4nD0KcD78090gAdFYUH7F6LpUGcn/JGHS4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXLvqle9DGtJdT/cRXWO88EsReYGgFNmGpZewMlbNq9nzAvqJ9hg6CNEL52pZNbC7gDteXZ8K8pDqMGhShHpL6yhLHnO7hXRifpbUH4ad7ekAGewGw7zC8jexm+QfWZVYHk4QxCVQUvit+UZCFuPyeF+2lrj9ql8tOgomPirkQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibP8Uf6B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibP8Uf6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD842C113D0;
	Tue, 30 Sep 2025 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759248400;
	bh=3VW6ohul4nD0KcD78090gAdFYUH7F6LpUGcn/JGHS4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibP8Uf6BdInkjBSmRLEaFyVW0zkXftwKi9RFJnEXczb6A4kLqurwGDB3GgTpWW3Kq
	 +WDXUwazExa4o8V4Z9BN1Ddbv8HVEa/ShmYYLYGGQy8NkCMBdNB98cpjXZQmYvMtZj
	 JWrgvD1pP/295Bq9gzzPbFBuquEu9PSVQdRkb48dQpc+h/vgcucRyLKg91Mh6DIoR9
	 xJJ70Ndq/1kln1aZQ1ZAN2y1W9LRxtb8FbzBNqhczZWsHCrVNwjL9zAzmC9cHA3IqG
	 BT0VLRupridck7Aim42fGq/nAIcmfAMMpMBkNJaou16kT/iHxHvYx43rtDKtWx74d6
	 h3RDtBNMbS8DQ==
Date: Tue, 30 Sep 2025 09:06:40 -0700
From: Kees Cook <kees@kernel.org>
To: David Binderman <dcb314@hotmail.com>
Cc: "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux-6.17 meets gcc trunk
Message-ID: <202509300859.BF057653FA@keescook>
References: <VI1PR02MB395284606387C101413494EB9C1AA@VI1PR02MB3952.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR02MB395284606387C101413494EB9C1AA@VI1PR02MB3952.eurprd02.prod.outlook.com>

On Tue, Sep 30, 2025 at 08:08:27AM +0000, David Binderman wrote:
> Hello there,
> 
> I just tried to compile linux-6.17 with gcc trunk. It said:
> 
>   HDRINST usr/include/asm/types.h
> In file included from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> scripts/gcc-plugins/gcc-common.h:176:25: error: ‘TODO_verify_il’ was not declared in this scope; did you mean ‘TODO_verify_flow’?
>   176 | #define TODO_verify_ssa TODO_verify_il
>       |                         ^~~~~~~~~~~~~~
> scripts/gcc-plugins/latent_entropy_plugin.c:567:27: note: in expansion of macro ‘TODO_verify_ssa’
>   567 | #define TODO_FLAGS_FINISH TODO_verify_ssa | TODO_verify_stmts | TODO_dump_func \
>       |                           ^~~~~~~~~~~~~~~
> scripts/gcc-plugins/gcc-generate-gimple-pass.h:86:43: note: in expansion of macro ‘TODO_FLAGS_FINISH’
>    86 |                 .todo_flags_finish      = TODO_FLAGS_FINISH,

This was fixed here:
https://git.kernel.org/linus/a40282dd3c484e6c882e93f4680e0a3ef3814453

It will need backporting to prior kernel releases.

-Kees

-- 
Kees Cook
