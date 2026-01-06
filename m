Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1008D2C326B;
	Tue,  6 Jan 2026 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767730481; cv=none; b=HXwG+eGPlpPjkBWqp1APqp69o8nAkrvb2k0qHLamKdMwxLATCb5O5W9Y4gtpx1pzOHHrhbXdvK51W7jV8d38B9T83uSKYpY8rSu7Z8c4k82YXBKMi5WblhLIWuiHtb74cmPUDlp6tZw8TIDZ8YVG8Kx2HF6+1PC48MNClA71KO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767730481; c=relaxed/simple;
	bh=X5Pea7bHPe0DI/5LIu59CR9OThlTHAfYphOoFvHkxbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFBOlzo/yJ+sQNCashuHAVccXGfMyKLOFs6RNSrLKWHUt+n50rA+mICygsr1jZR5zwEuzEIdt9loD846I+n+rYMcLcc3eovYp1Ppfx6aJkcQ1VYBa9OIvUUVsz0OXZr5XTmLAfJcTaSBqnkWD2hVYGQdyfyAV/jjhkaRWN9E+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFhJkLBQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFhJkLBQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76FEC116C6;
	Tue,  6 Jan 2026 20:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767730480;
	bh=X5Pea7bHPe0DI/5LIu59CR9OThlTHAfYphOoFvHkxbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qFhJkLBQjWOY6PRgiWE0ViVMNBHW39unXoZfg1BJ6oZhYFU1cb7/ZNNjzAkswlutv
	 7eyqDAp+7984CIersTXmE4LpI5KMgDyPKvpaEWhT+5sh8/eJjJfGIik/nJKnOcIWtX
	 iI7cr8JB/fd4UW5T4mOzw9GQIkUdgObI2tOvkpC80bqKZZP37/ngNxAxHScsP+pC3l
	 JkBLGJkg8oZYU37YH6BnbaHqKTnTwsdfmg0xXajrYhy3C6TUKoJsNt/mHWUQH1j20d
	 DkWJTUzVQPux+0MNvZUlPgVUquUhKKNce3I+J4wgJugjj5+KC6lpq3ywz7e0emHZUb
	 5KZiaaacbXaCg==
Message-ID: <b4e596b0-4e6d-40b8-933c-f407f2cc0980@kernel.org>
Date: Tue, 6 Jan 2026 21:14:36 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3][next] drm/nouveau: fifo: Avoid
 -Wflex-array-member-not-at-end warning
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aJ17oxJYcqqr3946@kspp>
 <e1009d16-cadb-4446-aef5-4a52197551a4@embeddedor.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <e1009d16-cadb-4446-aef5-4a52197551a4@embeddedor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 7:08 AM, Gustavo A. R. Silva wrote:
> Friendly ping: who can take this, please?
For some reason this patch wasn't tagged for applying in my inbox -- seems like
it slipped through.

I was about to pick it up, but recognized just in time that Kees already took it
through his hardening tree.

Sorry for the delay; thanks Kees for picking it up. Even though already applied,
please consider this patch:

	Acked-by: Danilo Krummrich <dakr@kernel.org>

Thanks,
Danilo
