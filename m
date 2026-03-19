Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3AB37B3F5;
	Thu, 19 Mar 2026 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961290; cv=none; b=Fw4aolAwwiNL3cZAfF7sHukYOGxiSPfIWDah4pcJ3WSNzcShW8ssWhCVrOV/u/VEv1cI6t5bVsI0U4D9kbBl0XQU4TWGfqDTq5S67LjN/C6DOUtm/8uthQrJTzebbX5RdnrXFFUivdRhvU9Ccu7Y/4Esyqn4GSe5xGrxcgBZc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961290; c=relaxed/simple;
	bh=8xilaayx3jaGNygf+ugYMv/lCvV0g6ijxcojYbWkBVQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BPnYe1TGLA0ztcrheOxt76hcylW+hXCyejB7hWS82v1+00R9Ki4OP+3HtcyyxXNkAKV13sRI/w+FY88Wb/RDZBa6AEOPvSVnI7NFnI4jTO+YzfgX+1hKOtcl+DjcMyzxnPOmx43yWzmdr8hgQsyPvrAyw+OxUql3N4BCKFyx08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C5BC2BC9E;
	Thu, 19 Mar 2026 23:01:30 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 313921808AD; Fri, 20 Mar 2026 00:01:28 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-kernel@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260318191037.5661-1-rosenp@gmail.com>
References: <20260318191037.5661-1-rosenp@gmail.com>
Subject: Re: [PATCHv3] hsi: hsi_core: use kzalloc_flex
Message-Id: <177396128818.536818.14023543892232129456.b4-ty@collabora.com>
Date: Fri, 20 Mar 2026 00:01:28 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 18 Mar 2026 12:10:37 -0700, Rosen Penev wrote:
> Simplifies allocations by using a flexible array member in this struct.
> 
> Add __counted_by to get extra runtime analysis.
> 
> 

Applied, thanks!

[1/1] hsi: hsi_core: use kzalloc_flex
      commit: e61af3ca893363838f263f3528476f6e1faed9aa

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

