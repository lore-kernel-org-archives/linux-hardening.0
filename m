Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA19D214A7A;
	Tue,  6 May 2025 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746519840; cv=none; b=c6JGUZlQeu8Ip8xkCljDq+Pvhve9exUYJrBlnxk7X29Hacg4R4ML1SuwBHMfwcOd+zBixAtTH9Jvy01omVPFCMti0yZhLtA0v2SGa8RXIxhrZXg28hfM9LG4hyDQBUg8f5H8qfxfEvU2nRO46XV0dsUzP9hkjseWkBUFihtOMTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746519840; c=relaxed/simple;
	bh=srSgp0bJ2iA1NXeUV/gyYc07gD8AbS+lHvn16Tx7Lz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bsij268HwY1Mzfn29PC04g1z1lCM1uMdjoa73J9atueglUd500/HxBZeZNta113dgbb92QPunS5K3odECOASilZjpfv8u7Dtd4h7feClhYtIfqAC16yav3pL7r32vhOjhQo8K//DyMzGdLBDP4yqzatmeQv2ib+M178MB2XrKeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=louischauvet.fr; spf=pass smtp.mailfrom=bootlin.com; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=louischauvet.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21FF243B63;
	Tue,  6 May 2025 08:23:54 +0000 (UTC)
From: Louis Chauvet <contact@louischauvet.fr>
To: Louis Chauvet <louis.chauvet@bootlin.com>, Kees Cook <kees@kernel.org>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20250426061431.work.304-kees@kernel.org>
References: <20250426061431.work.304-kees@kernel.org>
Subject: Re: [PATCH] drm/vkms: Adjust vkms_state->active_planes allocation
 type
Message-Id: <174651983405.14408.11022256268463069536.b4-ty@louischauvet.fr>
Date: Tue, 06 May 2025 10:23:54 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefgeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevjghfuffkffggtgfgofesthejredtredtjeenucfhrhhomhepnfhouhhishcuvehhrghuvhgvthcuoegtohhnthgrtghtsehlohhuihhstghhrghuvhgvthdrfhhrqeenucggtffrrghtthgvrhhnpeevueevleefveeugfejgefgueevleeftddvfedugffhkeeiiefgkeetleetueejgfenucfkphepvddttddumeekiedumeegudegtdemtgekiedtmeefuddukeemugeihedvmeejvddtjeemlehfheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemgedugedtmegtkeeitdemfeduudekmeguieehvdemjedvtdejmeelfhehpdhhvghloheplgduvdejrddtrddtrddungdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehlihhnuhigqdhhrghruggvnhhinhhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvghlihhss
 hgrrdhsrhifsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com


On Fri, 25 Apr 2025 23:14:32 -0700, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "struct vkms_plane_state **", but the returned type
> will be "struct drm_plane **". These are the same size (pointer size), but
> the types don't match. Adjust the allocation type to match the assignment.
> 
> [...]

Applied, thanks!

[1/1] drm/vkms: Adjust vkms_state->active_planes allocation type
      commit: 258aebf100540d36aba910f545d4d5ddf4ecaf0b

Best regards,
-- 
Louis Chauvet <contact@louischauvet.fr>

