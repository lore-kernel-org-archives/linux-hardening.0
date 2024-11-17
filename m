Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71A1AA1DA;
	Sun, 17 Nov 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846337; cv=none; b=pwHcy12v3smKjxsA8hdSPmtyRZB4O8lwXWhJ/IsOH/m976aZkODe3tCJ8e8KQxeBsCAFkeW1jqUgtULofNTTX6jL4dDuHSo443QxQvtwCAoLzrQt/Hl1FWnMuMrgLAIg0A9527OWny6gHH5Y6XNIXjTWK0I81Qc3dgZnhuVFV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846337; c=relaxed/simple;
	bh=7rEiE87ng3gR/xzR/SzcuhgMTarD9/lMFMlVXFlbDB0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jiqM+jvJX6JhscJQ1iItlbK1YtIfXD4I1BVizhIyN6magBBzepsrF+iwVy1kbR4g30BYFAUR0fAnerTqHX0emqhnoEC6SPSUWFjmOWKwQyZxQe4AIAA9N6ZqDanCnQC1LRxi/YQ/oaAB9AYKph85R7VmaY2buDuOPr3OU0HySh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Yhfn3sOt; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Yhfn3sOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846332;
	bh=svz/+d/BJbQJVr4DFdXqf+eDPKB8KH697JjZEyodgdM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Yhfn3sOtyEA0XnfnDCm2IXtldZDpbHEtVH2KhJmZIGo4M37GpbIOn1yBDho+Et1As
	 tM7DlcTqTjUQEtu2++BkGsPrjKoBygEgwgq9KGzNSZh1nd4D9gGz+pOB9JOLQPgmmE
	 Njq8Lxr1pwOx931dne9hEyIsAN+N6zLn7/FhtDRbbtXI8OGtxUgrNJCg/Q3pjeSLw9
	 GwQRlcSwZmnmqRIXOymUMPKkGJKCw2p3HSXhvAU6CEDaX9WWq/Q+/owGIIsIszVmi7
	 zm4zpIuyV8z/nPzqusVsuuU0ddC95ElmY0Rti9mwxOtpB0colXNfbr9YekS1TH/NR7
	 xsPV+41XUhC6w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqj83FZvz4xfW;
	Sun, 17 Nov 2024 23:25:32 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: geoff@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc: linux-hardening@vger.kernel.org
In-Reply-To: <ZxMV3YvSulJFZ8rk@mail.google.com>
References: <ZxMV3YvSulJFZ8rk@mail.google.com>
Subject: Re: [PATCH][next] powerpc/ps3: replace open-coded sysfs_emit function
Message-Id: <173184539744.890800.11374052691484660203.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sat, 19 Oct 2024 15:13:49 +1300, Paulo Miguel Almeida wrote:
> sysfs_emit() helper function should be used when formatting the value
> to be returned to user space.
> 
> This patch replaces open-coded sysfs_emit() in sysfs .show() callbacks
> 
> 

Applied to powerpc/next.

[1/1] powerpc/ps3: replace open-coded sysfs_emit function
      https://git.kernel.org/powerpc/c/2866949ec889cf383c481119c617b9cead733070

cheers
