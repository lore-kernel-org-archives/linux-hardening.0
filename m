Received: from greenhill.hpalace.com (greenhill.hpalace.com [192.155.80.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574F14D430
	for <linux-hardening@vger.kernel.org>; Fri, 29 Nov 2024 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.155.80.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732909130; cv=none; b=WTxJLLgZxBhWkpFdiv1XQuTFlNeOma66+d7LfT8avuDcJThGAza1L4MWL+wCNvFJTz7nxSmk0bh4PZosOhjHEfZzjqLV23zoJrHC2qzWM4h8al0DRDwbV3y3siC+/HkB0UixWejJziAMyGsxC2kQaHtVFzo2PunAG5QNFSYBydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732909130; c=relaxed/simple;
	bh=Xx2sLbPwO5fqD5+5gvDjI5hEnfk0nZ91zWELspJfm8s=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=GUHcGjWfWAMZOKSgpOSnbnGoA1Zr7sLAZN4rFe5iLUMv7R8+BVWACSxF6xH7rILIRq770YDaZZ5jbVHSUs7U1sGtX9qrk5pQf0uP+iDjDxyhoqQNWJh0a8/AKHA8BY9jRZyLs3l+xg4YWSjfpgL8YLfm8lUCVM/EBKbwpokC/dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=finder.org; spf=pass smtp.mailfrom=finder.org; dkim=pass (2048-bit key) header.d=finder.org header.i=@finder.org header.b=A76LjAzY; arc=none smtp.client-ip=192.155.80.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=finder.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finder.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finder.org header.i=@finder.org header.b="A76LjAzY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=finder.org; s=2018;
	t=1732908811; bh=Xx2sLbPwO5fqD5+5gvDjI5hEnfk0nZ91zWELspJfm8s=;
	h=Date:From:To:Subject:From;
	b=A76LjAzYKT7qowNsH0n9/1ut5gv190slO/zhMOX5wGQuJjw27gu7rv/YxfZ6p9CAf
	 jgjFQijjolWBScxztbm8F1+8sQgl/QPU9Od4k+/lrelUrHEkNAP+u/8kxjQXiT4xBC
	 lw/gLG4D8NRs9P5HkEgmemjZFOcLk40d78tieTRm8e8VWSA/UzaoZ+nMgsTwWrCQXl
	 zJSvYP0dUI2QRcTRN74Z8RoRKhR8k0xayU/kc9Ws/Kk/N6hLTg0JD8PRm+osacUpoW
	 zoIq5JbDxPEkUzabFZvHV8KFez8tKptaxQ8K3R6ScCzzxzthOVez2p4c7wtmrv+fUB
	 g7CnNxuRD47DA==
Received: from mail.finder.org (unknown [192.155.80.58])
	by greenhill.hpalace.com (Postfix) with ESMTPSA id 9EBA7138A
	for <linux-hardening@vger.kernel.org>; Fri, 29 Nov 2024 19:33:31 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 29 Nov 2024 11:33:31 -0800
From: Jared Finder <jared@finder.org>
To: linux-hardening@vger.kernel.org
Subject: GPM & Emacs broken in Linux 6.7 -- ok to relax check?
Message-ID: <ee3ec63269b43b34e1c90dd8c9743bf8@finder.org>
X-Sender: jared@finder.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

The change to restrict access to TIOCLINUX that was added in Linux 6.7 
breaks Emacs rendering of the mouse pointer. This change was previous 
discussed in 
https://lwn.net/ml/kernel-hardening/20230402160815.74760f87.hanno@hboeck.de/. 
An associated Emacs bug report, bug #74220, is discussed at 
https://lists.gnu.org/archive/html/bug-gnu-emacs/2024-11/msg00275.html.

I wanted to ask if it made sense for the restriction to not apply to the 
following three selection modes for TIOCL_SETSEL:

TIOCL_SELPOINTER   3 /* show the pointer */
TIOCL_SELCLEAR   4 /* clear visibility of selection */
TIOCL_SELMOUSEREPORT   16 /* report beginning of selection */

On a glance over the selection code, none of these interact with 
vc_sel.buffer and therefore are unrelated to the exploit linked in the 
original report. Only SELPOINTER is necessary to be available to fix 
Emacs bug #74220. I imagine such a change would involve moving the 
capability check from tioclinux(), case TIOCL_SETSEL to inside 
vc_do_selection().

Note: This is my first time emailing a Linux kernel mailing list, so 
please let me know if there's any additional conventions I should be 
following here.

Thank you for your time.

   -- MJF
