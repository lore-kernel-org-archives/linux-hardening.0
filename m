Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01522A80D
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781971239; cv=none; b=FYwz1OC+asuc89E4MayEaV2jTElHIOpepNepFcuT9t2+UqEcg/Ng5xyKs7vPchksZfPiB23CEhkIX8QAwf+LfB0XFgiklAfB52Bujr75li7eoLBL6etaXF7Soa7licQiTAgEKMUM2b0RWcqKmKWiadQCgspJLSy3TC38rPMxvKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781971239; c=relaxed/simple;
	bh=IiiqUF0WOz+MO2sQ0NAMrx75B0CKTr1/C/khxFKR7H4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e5aXD8+tRHUxBr4+mE0P/Y16uHV40/rF4trNWQxEnhMwEkOKUgE9IeUEsoe7hbC7bRUDeEQiJD7LumaH+yMQ7sqTwQmIEFYtw3eDNyo4BT8G3UQY2aNTbDUKs0RSI+PitOAn5ytM927UqWOgn8jzvGKipxgdp7LiSeyZbfSkqqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=VgqC8d79; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NIG6iwim; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="VgqC8d79";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NIG6iwim"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id 3D93D13002BA
	for <linux-hardening@vger.kernel.org>; Sat, 20 Jun 2026 12:00:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sat, 20 Jun 2026 12:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1781971237; x=1781974837; bh=IiiqUF0WOz+MO2sQ0NAMrx75B0CKTr1/
	C/khxFKR7H4=; b=VgqC8d79U0e3Q4xw7E2t9cGqDDUD34Mw+s85LW/o07CqnYBw
	MNnzW/Lj6k7n1BW/+7Ou4CqEzq5mxp2R4POYYsx1MnaIJhU+KerhhCRBSeAnwVQ0
	t1X6bdiaejtSJgDG+mhQ9zI0Qt8juifFNqcgyzgv55odxS5X2+P3C+xeyq4ZDfOe
	gPyBblvVFBOYejcCe5lUTSnCSinRApSFlwQ+ANa6053M9HjwWTuxsQNyosw9ElLv
	tiR8BCmua4sUpJJwGJcabMKTk0XG7MBTn31mhRNsGbLev4rS+zds0zKyWOy+5dp4
	O5n9pPhMMBzQ0SpJgzDrBk7v0VyeyhX3JBKu+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781971237; x=
	1781974837; bh=IiiqUF0WOz+MO2sQ0NAMrx75B0CKTr1/C/khxFKR7H4=; b=N
	IG6iwimttFlOox30nb9bJnkdpU5j+DvZUrb1SemoauVTIk/IV4vnEUAl9OvHcedJ
	xI34pRbAY1BQBy+lZMQgjIQssGfciOFpc1tbIqTC2y6SvTUPoefauFKfzRBDQ18J
	kopor3hU9L1neTfPKxYQ12tVNoE+rRsUanVlJSN8b9RFhNt6+NEhOJHOSWGk39uo
	RTx5bZSMa1kauxyZevlU39EadB6NiNcxvn58aIUcweGK1YXcYH2C9HOKXwbxlxq4
	9kzO+LsXS9u+XlRnNG92oXDGCAnESXtWD7/A47ZKwhno1mH8b1x65dLEwbjhtK20
	XaglCI1RqkWK1mi0SFeCg==
X-ME-Sender: <xms:JLk2asIlR9NBzW1A1Yja2s7xnQmD6nndv2i8OJnOe9Guj252ssZyRw>
    <xme:JLk2ajF0r5IZHGSHWKsXFV74qjm4NbMep3C3UijzU1OW_bNceCP2JM0YdT8IjW8uj
    xSbxr3wQ65NqgWk4547x3oAwxmDbKepWSkIYt1DHmz_62lczt6kcC21>
X-ME-Received: <xmr:JLk2aiXqZi7NXURwHZ5UAfwMsfTD1Wo0ifUPTotmu1zAoim5r9d7qHfj4-A>
X-ME-Proxy-Cause: dmFkZTE5Xqcncgc7X9ONcKhOlnpFHwEadfku3h+mQk4ML4XAi7444w3luGactfxRhx92El
    6ebsu4UBrLjZAoVQBm4SvxO2cDpDWqVAAgFnOGsnUkHsV2Gj3lmPJAUkvQWjD5vdMJwEPj
    LrJwwJRktfZ53JYKiP0aD5tCFXNPQUWil72/DSbYAR4znr0b5JhtyeaebanqlMAG4SB/xL
    4wwybL32kM8fjayYX34lZeKTCqyGtjpGaJyrsbIBv3f/SJJ/dYSHnntnRbS95bh9Vwg5zK
    r4/ENAlkEzKnbnMCqjiLJmwW0oqGSbI7cM0BHfRFDJNirb+HEIF4EaJ0dJBBvbMNTn/4PZ
    iaVCkyxZXUiLt6PCHtN3SxvQTAqWERNxuA+EOodyA9r7SVaOxd3lW15sUwTko2mOPrznM2
    u/ziDKJfWSybRhZHHOZfTbXotsj6pSzV1V/cU1GVWlHLxv3AoqHX8GgqsmbhuFQ+Hiorf6
    z97IAqVZViVxVMb0cjdQgAgexQQak2nC6k08gStFKow7Q7FuluevGQpHlv/L6kFZzyEPLC
    ESA5q9NMZ4Ga8uNOKj6mB2u3g1h27zjwV8GECO0Iw3YzOB0sgaSn1DJvVFDDXbpksMADuv
    +5rjC/1Tf4HlRLhYy3l++kvn7VpzU2SdzdmW7JdADApk4lAMMAtfZXeM4xfw
X-ME-Proxy: <xmx:JLk2auhwwJDO1efUwLCPDiKT6AZ0uM3BWixhsw3q5XBNNl95x0Y61w>
    <xmx:JLk2ajR4ZW48WAo4tGUWoB-1gzvdK2ukh51o8gn_NpEJYbYXxfV0pg>
    <xmx:JLk2ahHTzdT4sHOTtYRFSQd5Wh4KHoN8lWXE0anXPWXUNCmSANcqXg>
    <xmx:JLk2arkt7-fog66x1mc5vQJyOKnL1XWrfoA1VbVuw-stA8UJ9SPHQA>
    <xmx:Jbk2agJ2sOkxZFbWJTA4PLJWhD645jkK-f90ogaD-r7-Z8ufTdRO_Be2>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-hardening@vger.kernel.org>; Sat,
 20 Jun 2026 12:00:36 -0400 (EDT)
Date: Sat, 20 Jun 2026 11:00:34 -0500
From: Ian Bridges <icb@fastmail.org>
To: linux-hardening@vger.kernel.org
Subject: Introduction
Message-ID: <aja5Iqqs2_VfwBNe@dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

My name is Ian and I'd like to get involved with the linux kernel
hardening work. My professional background is in computer security and
I've got some graduate school experience with compiler-based hardening
(specifically with the FreeBSD kernel, though). I've submitted a few
patches to fix syzbot-identified bugs in the past few weeks and really
enjoyed the process, which brought me to this group. I'm looking forward
to jumping into one of the "good first issue" entries in the public
issue tracker (maybe #370).

Ian
