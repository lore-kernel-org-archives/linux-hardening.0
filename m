Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30CB2153F7
	for <linux-hardening@vger.kernel.org>; Mon,  3 Mar 2025 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022285; cv=none; b=CAf4kFSbXHxNSa7LQcLvPudOriRHL4igefvxJTmgcoo3e5TzSBYBTyMFaIvYtD7jWvs4OL5ZEzsRbX91MoVwCiGDtakiAQKi2VXnEFaj84slELVB6PBfxvavv2WOsI4fbcX1IHT9TOuK6bknM/RbnY15yS7ORn2tAmPJ6AMgLmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022285; c=relaxed/simple;
	bh=V2Ie10wQUXloxZeJ2MQE6IhJ6q3P5prVv5HAqJjEtIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGBBc2gTtkXuO3bxXO5f2xC+5xRVz1LYC40brbhMV83Kse3sCNU/NwVTu8GQoQjl7B46JGh4aDF/Tlf/7G4OVHat5ydOSSGueMHn4jFpLlwKws8sfleljy26GsWDGpVLQlMxoybBxK3V51lNcC0if/IlLGaBDlh7xTU0EOKhWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivBaPbWp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivBaPbWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3477FC4CED6;
	Mon,  3 Mar 2025 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741022285;
	bh=V2Ie10wQUXloxZeJ2MQE6IhJ6q3P5prVv5HAqJjEtIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivBaPbWpoE15iGYxAafq83zsrkZQ5VlKPT++9mbePxkuucL1fLQxUnsEECTwNWzG0
	 G8sDAtaZELh9cXapzbNDiAiQkYLMRsww/fRYwM6X72u57oqcXTxIIxJIy+O1pbg7ZH
	 0uYac0W8TvB7pOLCpgQyFE5Eb/kOcJ9lULe0993Q62uoJFZT6glfUCu/hfzx0V5q4p
	 ndBX6Txz1xGESNGdLln7Q44xiks5Y/PQTCRiOHYxE3eAmqNJECF5c1sNyUQ4bN3ZUr
	 b/bGKJBGSgC4yb8X7BjYd16ehVSAg3qyCpgP/KDPfxhgK4RruDOnlilSvqNPytCJmn
	 t9f7sUJQ6+VLQ==
Date: Mon, 3 Mar 2025 09:18:01 -0800
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 00/10] lib/string_choices: Add new helpers
Message-ID: <202503030917.6A99B05D2D@keescook>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
 <202502281143.149423E53@keescook>
 <CAHp75VdX_LtL8vJAjwSqHfW9KbLGV5xhjX4MjFnpFo0VA2SMWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdX_LtL8vJAjwSqHfW9KbLGV5xhjX4MjFnpFo0VA2SMWA@mail.gmail.com>

On Fri, Feb 28, 2025 at 10:24:22PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 28, 2025 at 9:44 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Wed, Feb 26, 2025 at 05:34:48AM +0000, Kuninori Morimoto wrote:
> > > I would like to use string_choices helper to cleanup the code, but it missing
> > > some of well used string pair in kernel. This patch-set adds it.
> >
> > Do you have some Coccinelle scripts or other patches that show the use
> > of these helpers? We tend to avoid adding new helpers to the kernel
> > unless there are active uses of them.
> 
> Kees, what is the status of the
> https://lore.kernel.org/linux-kernel/20241119021719.7659-1-prosunofficial@gmail.com/
> ?

Fell through the cracks! I've applied patch 1 now.

If we can see some conversions for locked/unlocked, we can do patch 2 as
well.

-Kees

-- 
Kees Cook
