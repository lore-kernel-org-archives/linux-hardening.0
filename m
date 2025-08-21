Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D2E28E0F;
	Thu, 21 Aug 2025 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817020; cv=none; b=rIU1x2mKbjCr7hoHGM18+pj85wjtFnJokifi4g088kRyD7S0pViJmG4yBmBFcu5dGbzopg0UfQLW2IARBshij0E92ru44VDi2CSrYe03TD8zw+i2KhNBCPw7MBtI2LBEUAmef2jjffyW0ZteOloEj3szubG8OFTkb1Hh/rhVOsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817020; c=relaxed/simple;
	bh=ZIKndEaJuQTA/UnmIgtD9PZDRtHtwHVhIqNs2rBI/2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhP0u4f0O/SPzizgv5BLSAw3v8tgiS4eeZSWL3F4eYYKO4eO15dwvr6vmLZ4R3jwyCAprOBU6BC42ygNA1DbubrYeCyK+OptBkhu6G7PW6T2GOLi9QVlu03zyykImi8oP5d2uheuWb+w6h6tlUG+WQjDSuvLlN1cDJUGvjvM+dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJ6WrPVu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJ6WrPVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9966C4CEEB;
	Thu, 21 Aug 2025 22:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755817019;
	bh=ZIKndEaJuQTA/UnmIgtD9PZDRtHtwHVhIqNs2rBI/2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cJ6WrPVuoRGLtL3Rbq2bYVMICYzm7xX8rEhtBVaKNQen9SOVq04k8/Gj4TEqH5uml
	 4NGg3ZqGNJeHvqcgqG+dRW5JxBlz2ivC+BKp0aAgSlqF35Bab02Rv87ikNZdFtIgdL
	 sqB9pQDXG/cuAMtSptpzTOMtrngDtyfFpKJjMj4p3Tm/bX7GFag4BT5I2ZK69klw1A
	 z3KvPU0I4i89sZzE2kUR/kuhnl90FlqnDiq0/iHclX+/fzVBFaZRFJOPvmuQd+u9qn
	 vCPv3dtFiaoybG+qaCA0x49UJLXE3BLq9Yjjl26bqgSSsOJj2K7urMsYL9lv8OuEid
	 qWP73peCKz3OA==
Date: Thu, 21 Aug 2025 15:56:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
 gustavoars@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v6 0/5] Add driver for 1Gbe network chips from
 MUCSE
Message-ID: <20250821155657.3837dae6@kernel.org>
In-Reply-To: <20250820092154.1643120-1-dong100@mucse.com>
References: <20250820092154.1643120-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 17:21:49 +0800 Dong Yibo wrote:
> This patch series is v6 to introduce support for MUCSE N500/N210 1Gbps
> Ethernet controllers. I divide codes into multiple series, this is the
> first one which only register netdev without true tx/rx functions.

Looks like there was more feedback on v5 after this was sent.
We're expecting v7..
-- 
pw-bot: cr
