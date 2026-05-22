Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7DB378D87;
	Fri, 22 May 2026 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464589; cv=none; b=AvsyDR9NMWQMiWA2pYmMusDTGKi3iUhPZBEsJY41ZqOlriUxgJdT0g4hAv4M+eh1fR1qYVrVL3guDA/fK4ZoLEkEynN++yy/V82W9GJWPf7IMmmqkfxAItacURxrRM4aYtieK7P6lZGP+w+XgEnGjtKzypY2rWH0xZ7Wvk5Q+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464589; c=relaxed/simple;
	bh=AETpzy5p54GuqpRgsu98hGf8MVpdMecsNS0ozTBCqUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=msGhgJT3bPUarPsXToUX0EW9MAklalUkLOsteqC4LWOCUECc4RaZNxYt7alm2PUFKlXEi6TklIIAUoJbALLk0C7xD7p42pjcB3Q6XnasDgJcwLy0jiQ865BsBzb8KHMwVjS8zfRLg6jEqqwTt/GQSbAOuv8LWGGx++LHi92o6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjycqiGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjycqiGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5651F000E9;
	Fri, 22 May 2026 15:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464588;
	bh=jfZ2Ie3b5ezLZ6PyHs8eSozn31QBM+Ulbd6lqUIif98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PjycqiGXKeNMNoKbkBLPcxv2zDfqxkK/+CTvi3NoXEHhs0PBxoMcjIWnhrbWErOa/
	 ZTwUmFZqZEu7vUJucvytstExD/gi4Il6Eo2hs/HGwtTwWEgbNFqr54vhdA5gNprs3v
	 p4Hif/3D1/hy7lUhdxsrmilSplf8HfCFgP1heHWk2xRQd8rUq5NoK+berfyKVjubPv
	 nyrbIccTkfg/foKoQeEAbG3n+SGo0CgRQqf9NRr6en70x13DnFPkSIj/Mq7Xhj5/5I
	 hIdd84bP4VCPh9TuUhA1L6rcHvwtoYXEvrDBPyM+0P1Bf99qz+axSZsxpawDVxSvlb
	 X+ORsGzw0e8aQ==
Date: Fri, 22 May 2026 08:43:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Andrew Morton
 <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib: objagg: Use flexible arrays for object storage
Message-ID: <20260522084307.62262c64@kernel.org>
In-Reply-To: <20260519015833.634602-1-rosenp@gmail.com>
References: <20260519015833.634602-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 18:58:33 -0700 Rosen Penev wrote:
> Store object payloads and temporary graph nodes in their parent
> allocations instead of open-coding trailing storage or allocating the
> node array separately.
> 
> Use byte-sized flexible arrays for object payloads so kzalloc_flex() is
> passed the same byte count as the previous allocation sizes.

Nobody acked this and I think it's pointless code churn so rejected.
Please be mindful of reviewer time when you send patches.
