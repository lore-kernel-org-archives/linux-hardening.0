Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73725374D2;
	Mon, 16 Oct 2023 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYcuvI1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C04C433C7;
	Mon, 16 Oct 2023 23:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697498034;
	bh=3R5dUBn2483stJZw4ASF6hREmPIo9l5rKKo6lGtoAgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YYcuvI1g/SeSLUmhrYbWCqJSDUbl6GSyzl3TJL2eYq2GJBf/9fg5zSnl/YOsQo7Ky
	 Er08FyYRfGeVzA2x2lCbd7ecBigQDfG8rka3peAzM5fEY8dO9JVZoj9GQKE8ZcNuyD
	 Y0sziQcyZwtqNCSduNcFXBe/2LTrIQLaEO3NOK1cVSUAlmij3xdE+WvHNyy7KZfhRY
	 H6tjqkFKiG7yPIynnmuzRA/rTlxN0XDpI+d5ehvonzoxBCYEpJGgSYNhHZBAjZ0cHU
	 12bsb2YAyvUusFiLD5wu+2poZlheBocmgH1N8k5rx03gXilIOAvGSlFmQcy4XHD1he
	 f1li2eMtKW4ig==
Date: Mon, 16 Oct 2023 16:13:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: cpmac: replace deprecated strncpy with strscpy
Message-ID: <20231016161353.48af3ed7@kernel.org>
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-ti-cpmac-c-v1-1-f0d430c9949f@google.com>
References: <20231012-strncpy-drivers-net-ethernet-ti-cpmac-c-v1-1-f0d430c9949f@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 20:53:30 +0000 Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.

This driver no longer exists. Praise be.
-- 
pw-bot: reject
