Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31371519AD
	for <linux-hardening@vger.kernel.org>; Sat, 22 Mar 2025 03:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742614612; cv=none; b=Qn9JEyB6236jfvepH48PSmY0TGJ6DWisYo8AT8IOAO/JpKA9J+mZzQUI85vYcOkzUOZen3X+dxqK9xxAiL4/F/afNmQydwEPT56FQ7Y78Q+hGwsBBypw1qZZAn15FH2RXliZ7XaewtsKd6yS+6w2C9jlYzHlMsWeKKSJ3lFWeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742614612; c=relaxed/simple;
	bh=JqsvHkEtR1js2oxw1GhdUI0c2XgtruxlopFr7w7MbvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAjWtmF1kCUCIl16HUy19YSO/zh8RuuFRtQ8ZWxedyO6Z6TzpTZBniu7q9ScMUKfViFxtp9+TXOJUj+8QZACzLbJU1l2qz6sCXbXewFWYCtPCKKJNqWXYScvJYKa6JmRbDM8ZAp6ZDeaa7neOSx26/HiP9gUAW5Viw8mn9xJCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52M3aMDI007707
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 23:36:23 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BC54E2E010D; Fri, 21 Mar 2025 23:36:22 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>, Andreas Dilger <adilger@dilger.ca>,
        Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ext4: hash: simplify kzalloc(n * 1, ...) to kzalloc(n, ...)
Date: Fri, 21 Mar 2025 23:36:16 -0400
Message-ID: <174261457016.1344301.3520847990943957158.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250316-ext4-hash-kcalloc-v2-1-2a99e93ec6e0@ethancedwards.com>
References: <20250316-ext4-hash-kcalloc-v2-1-2a99e93ec6e0@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 16 Mar 2025 01:33:59 -0400, Ethan Carter Edwards wrote:
> sizeof(char) evaluates to 1. Remove the churn.
> 
> 

Applied, thanks!

[1/1] ext4: hash: simplify kzalloc(n * 1, ...) to kzalloc(n, ...)
      commit: 1e93d6f221e7cfe5e069583a2b664e79eb361ba6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
