Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE7211CA9;
	Thu, 13 Mar 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874605; cv=none; b=CcRsEmkHKlGo3ywytKO8xKyx3XCnc6qY564NXdxj/ECe6i5ixOhPSk6gND34sYv1O9d17ddtqvyefcF00bHFbM0h2jpJhjH9wS232GWw7rYRROvvjFVAINl/fBXupm035bmunZuWf0I/rpgbha338vu0CywRidVmM8g/XTbrXi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874605; c=relaxed/simple;
	bh=5GOXMi43b2br+eJe7B+HzXuFeUte47U460ED9s1ePqg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pGWjTMKeKWaRJ9GzjwLVXkx9McVlxfWed9YvzRm8j0tQ+K/cIt1puueKHbPthYxmwllbi/mL1Kncr2Lf00IZrlhCL66ZRHSZX8D2VSKj/J39BaeSLhh8uoN3uJNZ80flOdPQUn7RSlkbbVwN7jijPDtAoWgSwMGxO6JLli/BZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jPDw6ug8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jPDw6ug8"
Received: by linux.microsoft.com (Postfix, from userid 1218)
	id C510E210B174; Thu, 13 Mar 2025 07:03:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C510E210B174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741874603;
	bh=eJL1r7Uke2I0Gu+6nN6SjJW+WcL3S+JauWgGgw37SJA=;
	h=From:To:Cc:Subject:Date:From;
	b=jPDw6ug8qjHWz0ptpuH3a6V4o17/C2BYmBdukR5ltocowSiEqafTtwW5BvKjEKmb5
	 gaSQe1h15mIoqqe0QiMva6i1LviLdSgKXxz/PQzzGKj2sgb3iQacYq+5N/T9ea2Vyg
	 kTY5nt/mGzl9LxZPMDDgdoMfGGOZzlqmoqAUElaI=
From: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kees@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: abhitiwari@microsoft.com,
	Abhishek Tiwari <abhitiwari@linux.microsoft.com>
Subject: [PATCH] dt-bindings: memory: Document linux,usable-memory property
Date: Thu, 13 Mar 2025 07:02:25 -0700
Message-Id: <1741874545-19091-1-git-send-email-abhitiwari@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>

Add Documentation for linux,usable-memory

Signed-off-by: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
---
 .../bindings/linux,usable-memory.txt          | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/linux,usable-memory.txt

diff --git a/Documentation/devicetree/bindings/linux,usable-memory.txt b/Documentation/devicetree/bindings/linux,usable-memory.txt
new file mode 100644
index 000000000000..167054d2e9a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/linux,usable-memory.txt
@@ -0,0 +1,32 @@
+linux,usable-memory
+===================
+
+Description
+-----------
+The ``linux,usable-memory`` property can be used to restrict usable memory
+region. This property holds a base address and size, Memory outside of this
+range is not accessible by the kernel. This property is particularly useful
+in specialized hardware platforms where certain memory regions must be
+reserved for specific use.
+
+Common use cases include:
+- Allocating ``ramoops`` region
+- Reserving memory for hardware-specific needs
+- Fake Protecting persistent memory (PMEM)
+
+Valid memory may be sparse within the specified range.
+An example device tree configuration is shown below:
+
+.. code-block:: dts
+/ {
+	&memory {
+		linux,usable-memory = <
+			0x00000000 0x80000000 0x00000000 0x1BA00000
+			0x00000000 0xA1000000 0x00000000 0x2AC00000
+		>;
+	};
+};
+
+While this property does not represent a real hardware, the address
+and the size are expressed in #address-cells and #size-cells,
+respectively, of the root node.
-- 
2.48.1

